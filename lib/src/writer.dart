import 'dart:io';

import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';
import 'package:flutter_tui/src/models/window.dart';

class Writer {
  static Writer? _instance;

  static Writer get instance {
    if (_instance == null) {
      throw Exception("Call 'createWriter() first!");
    }
    return _instance!;
  }

  WriteObject? _root;

  // Private constructor
  Writer._();

  static Writer createWriter(Widget root) {
    if (_instance != null) {
      throw Exception("This should be called at the beginning of the app!");
    }

    _instance = Writer._();
    final onlyInstance = _instance!;

    // Build root constrained by terminal width and height
    onlyInstance._root = root.build(Size(
      width: stdout.terminalColumns,
      height: stdout.terminalLines
    ));

    return onlyInstance;
  }

  void display() {
    if (_root == null) {
      throw Exception("Call createWriter() first!");
    }

    var file = File("log.txt");
    file.writeAsStringSync("");

    // Clear screen
    final clearScreenInstructions = Window(size: _root!.size).clear();
    for (final instr in clearScreenInstructions) {
      stdout.write(instr);
    }

    List<WriteObject> stack = [_root!];
    while (stack.isNotEmpty) {
      WriteObject currentObj = stack.removeLast(); // Object at top of stack
      file.writeAsStringSync("${currentObj.size}\n", mode: FileMode.append);

      if (currentObj.hasText) {
        var pointer = currentObj;
        var startingPosition = pointer.size.start;
        while (pointer.hasParent) {
          pointer = pointer.parent!;
          startingPosition += pointer.size.start;
        }

        final currentWindow = Window(
          size: currentObj.size.copy(start: startingPosition)
        );
        final writeSequence = currentWindow.write(currentObj.text!);
        for (final write in writeSequence) {
          stdout.write(write);
        }
      }
      
      // Add children to stack
      for (int i = 0; i < currentObj.childCount; i++) {
        stack.add(currentObj.getChild(i));
      }
    }
  }

  // void update(Widget widget) {
  //   WriteObject? oldObj = _findWriterObject(widget);
  //   if (oldObj == null) {
  //     /*
  //       Kinda sus.
  //       We're trying to write an object that does not exist
  //       in the widget tree.
  //     */
  //     throw Exception("Cannot write. Widget is not in tree");
  //   }

  //   WriteObject? parent = oldObj.parent;
  //   if (parent == null && widget.key != _root!.widgetKey) {
  //     // Only the root should have a null parent
  //     throw Exception("Something's wrong here. A non-root widget "
  //             "should have a parent");
  //   }

  //   late WriteObject newObj;

  //   // Root widget
  //   if (parent == null) {
  //     Size terminalSize = Size(
  //       width: stdout.terminalColumns,
  //       height: stdout.terminalLines
  //     );
  //     newObj = widget.build(terminalSize);
  //   } else {
  //     newObj = widget.build(parent.size);
  //   }

  //   // No change to render object
  //   if (oldObj == newObj) {
  //     return;
  //   } else {
  //     // TODO: Update writer object in tree
  //     // TODO: Build adjaceny list
  //   }

  //   // TODO: Go through tree and write at each root level
  //   Window window = Window(size: newObj.size);
  //   stdout.write(window.clear()); // Clear window
  //   stdout.write(window.write(newObj.text)); // Display
  // }
}
