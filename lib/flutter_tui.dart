import 'dart:io';

import 'package:flutter_tui/src/context.dart';
import 'package:flutter_tui/src/widget.dart';

void runApp(Widget widget) {
  stdout.write("\x1b[?1049h");  // Enter alternate buffer
  stdout.write("\x1b[?25l");    // Hide cursor
  stdin.echoMode = false;       // Don't show characters
  stdin.lineMode = false;       // Don't wait until the user presses enter

  Context context = Context();
  context.clearScreen();

  bool quit = false;
  // Exit condition
  stdin.listen((List<int> bytes) {
    if (bytes.isNotEmpty && bytes.contains(3)) { // Ctrl+C (ASCII code 3)
        quit = true;
    }
  });

  context.writeToScreen(widget.build(context)); // Initial write
  while (!quit) {
    // Redraw when there's an update
    if (widget.didUpdateWidget()) {
      context.clearScreen();
      context.writeToScreen(widget.build(context));
    }
  }

  stdin.echoMode = true;
  stdin.lineMode = true;
  stdout.write("\x1b[?25h");    // Unhide cursor
  stdout.write("\x1b[?1049l");  // Exit alternate buffer
}
