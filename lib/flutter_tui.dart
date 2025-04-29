import 'dart:io';

import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/util.dart';

// TODO: Expanded (https://api.flutter.dev/flutter/widgets/Expanded-class.html)
// TODO: Switch to `tput` and `stty`?
// TODO: Grid
// TODO: Input field

Future<void> runApp(Widget parent) async {
  _start();

  KeyboardHandler keyboardHandler = KeyboardHandler.instance; 
  keyboardHandler.addListener((key) {
    if (key == "ctrl+c" || key == "q") { // "ctrl+c" does not work yet
      _end();
    }
  });

  Writer writer = Writer.createWriter(parent);
  writer.display();

  await Future.delayed(Duration(days: 365)); // Keep alive indefinitely
}

// Future<String?> _runStty(List<String> arguments) async {
// 	final result = await Process.start("stty", arguments);
// 	int exitCode = await result.exitCode;
//   if (exitCode != 0) {
//     throw Exception(result.stderr.);
//   }

//   return result.stdout.toString().trim();
// }

// void _runTput(List<String> arguments) {

// }

 void _start() {
  stdout.write("\x1b[?1049h");  // Enter alternate buffer
  // _runStty(["raw", "-echo"]); // Enter raw mode
  stdout.write("\x1b[2J");      // Clear screen
  stdout.write("\x1b[H");       // Move cursor to (0, 0)
  stdout.write("\x1b[?25l");    // Hide cursor
  stdin.echoMode = false;       // Don't show characters
  stdin.lineMode = false;       // Don't wait until the user presses enter
}

void _end() {
  stdin.echoMode = true;
  stdin.lineMode = true;
  stdout.write("\x1b[2J");      // Clear screen
  stdout.write("\x1b[?25h");    // Unhide cursor
  stdout.write("\x1b[?1049l");  // Exit alternate buffer

  exit(0);
}
