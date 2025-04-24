import 'dart:io';

import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/writer.dart';

void runApp(Widget parent) {
  bool echoMode = stdin.echoMode,
      lineMode = stdin.lineMode;

  stdout.write("\x1b[?1049h");  // Enter alternate buffer
  stdout.write("\x1b[?25l");    // Hide cursor
  stdin.echoMode = false;       // Don't show characters
  stdin.lineMode = false;       // Don't wait until the user presses enter

  bool quit = false;
  // TODO: Handle keyboard input in separate class
  stdin.listen((List<int> bytes) {
    if (bytes.isNotEmpty && bytes.contains(3)) { // Ctrl+C (ASCII code 3)
        quit = true;
    }
  });

  Writer writer = Writer.createWriter(parent);
  writer.display();

  while (!quit) { }

  stdin.echoMode = echoMode;
  stdin.lineMode = lineMode;
  stdout.write("\x1b[?25h");    // Unhide cursor
  stdout.write("\x1b[?1049l");  // Exit alternate buffer
}
