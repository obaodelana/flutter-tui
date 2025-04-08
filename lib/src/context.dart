import 'dart:io';
import 'dart:math';

class Context {
  final int width, height;
  ({int x, int y}) cursorPosition = (x: 0, y: 0);

  Context() :
    width = stdout.terminalColumns,
    height = stdout.terminalLines;

  void moveCursorTo(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) {
      return;
    }

    cursorPosition = (x: x, y: y);
    stdout.write("\x1b[$y;${x}H");
  }

  void clearScreen() {
    stdout.write("\x1b[2J");  // Clear screen
    moveCursorTo(0, 0);
  }

  void writeToScreen(String msg, [int? x, int? y]) {
    // Either both are specified or none
    assert((x == null && y == null) || (x != null && y != null));
    if (x != null && y != null) {
      moveCursorTo(x, y);
    }

    final msgLen = msg.length;
    final newX = cursorPosition.x + msgLen;
    final newY = cursorPosition.y + (newX / width).toInt();

    stdout.write(msg);

    // New cursor position
    cursorPosition = (x: newX % width, y: min(newY, height));
  }
}
