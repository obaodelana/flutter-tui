import 'dart:io';

import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/models.dart';

class Writer {
  static Writer? _instance;

  static Writer get instance {
    if (_instance == null) {
      throw Exception("Call 'createWriter() first!");
    }
    return _instance!;
  }

  WriteObject? _root;
  Size get _rootConstraint => Size(width: stdout.terminalColumns,
    height: stdout.terminalLines);

  final _registerTable = <Widget, WriteObject>{};

  // Private constructor
  Writer._();

  static Writer createWriter(Widget root) {
    if (_instance != null) {
      throw Exception("This should be called at the beginning of the app!");
    }

    _instance = Writer._();
    _instance!._root = root.build(_instance!._rootConstraint);

    return instance;
  }

  void registerWidget(Widget widget, WriteObject object) {
    _registerTable[widget] = object;
  }

  void display([WriteObject? object]) {
    object ??= _root; // Default to root object
    // If object is still null, then root is null
    if (object == null) {
      throw Exception("Call createWriter() first!");
    }

    // Clear screen where object resides
    final clearScreenInstructions = Window(size: object.size).clear();
    stdout.writeAll(clearScreenInstructions);

    List<WriteObject> stack = [object];
    while (stack.isNotEmpty) {
      WriteObject currentObj = stack.removeLast(); // Object at top of stack
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
        stdout.writeAll(writeSequence);
      }

      // Add children to stack
      for (int i = 0; i < currentObj.childCount; i++) {
        stack.add(currentObj.getChild(i));
      }
    }
  }
  
  void update(StatefulWidget widget) {
    if (!_registerTable.containsKey(widget)) {
      throw Exception("Stateful widget does not exist in tree!");
    }

    // Get currently displayed object
    WriteObject oldObj = _registerTable[widget]!;

    WriteObject? parent = oldObj.parent;
    late Size constraint;
    if (parent != null) {
      // Since the parent didn't change, it's still a valid constraint
      constraint = parent.size; 
    } else {
      // If it doesn't have a parent, then it's the root object
      constraint = _rootConstraint;
    }

    WriteObject newObj = widget.createObject(constraint);
    _registerTable[widget] = newObj;

    display(newObj);

    /*
      In case there are other widgets in the register table that
      are affected by this new build, I will go traverse the old object's
      children and update their sizes.
      TODO: Make this automatic
    */
    List<(WriteObject, WriteObject)> stack = [(oldObj, newObj)];
    while (stack.isNotEmpty) {
      final (o, n) = stack.removeLast(); // Object at top of stack

      o.size = n.size; // Update size

      // Add children to stack
      for (int i = 0; i < o.childCount; i++) {
        stack.add((o.getChild(i), n.getChild(i)));
      }
    }
  }
}
