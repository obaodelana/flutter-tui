import 'dart:io';

import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/writer_object.dart';
import 'package:flutter_tui/src/widget.dart';
import 'package:flutter_tui/src/models/window.dart';

class Writer {
  static Writer? _instance;

  static Writer get instance {
	if (_instance == null) {
		throw Exception("Call 'createWriter() first!");
	}
	return _instance!;
  }

  WriterObject? _root;

  // Private constructor
  Writer._();

  static Writer createWriter(Widget root) {
    assert(_instance == null, "This should be called at the beginning of the app");

	_instance = Writer._();
	// Build root constrained by terminal width and height
	_instance!._root = root.build(Size(width: stdout.terminalColumns, height: stdout.terminalLines));

	return _instance!;
  }

  WriterObject? _findWriterObject(Widget widget) {
	if (_root == null) {
		return null;
	}

	List<WriterObject> frontline = [_root!];
	WriterObject? current;

	while (frontline.isNotEmpty) {
		current = frontline.removeAt(0); // BFS
		if (current.widgetKey == widget.key) { // Found it
			return current;
		}

		for (int i = 0; i < current.childrenCount; i++) {
			frontline.add(current.getChild(i));
		}
	}

	return null; // Did not find key
  }

  void write(Widget widget) {
    WriterObject? oldObj = _findWriterObject(widget);
	if (oldObj == null) {
		/*
		 	Kinda sus.
			We're trying to write an object that does not exist
			in the widget tree.
		*/
		throw Exception("Cannot write. Widget is not in tree");
	}

    WriterObject? parent = oldObj.parent;
	if (parent == null && widget.key != _root!.widgetKey) {
		// Only the root should have a null parent
		throw Exception("Something's wrong here. A non-root widget "
						"should have a parent");
	}

	WriterObject? newObj;

	// Root widget
	if (parent == null) {
		Size terminalSize = Size(
			width: stdout.terminalColumns,
			height: stdout.terminalLines
		);

		newObj = widget.build(terminalSize);
	} else {
		newObj = widget.build(parent.size);
	}

    // No change to render object
    if (oldObj == newObj) {
      return;
    }

    Window window = Window(size: newObj.size);
	stdout.write(window.clear()); // Clear window
	stdout.write(window.write(newObj.text)); // Display
  }
}
