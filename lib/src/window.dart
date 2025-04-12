import 'dart:io';

import 'package:flutter_tui/src/models/position.dart';
import 'package:flutter_tui/src/models/size.dart';

// Represents a window
class Window {
  final Size _size;
  Size get size => _size;

  Position _cursorPosition;

  Window({required Size size}) : _size = size, _cursorPosition = size.start;

  void moveCursorTo(int x, int y) {
    Position offset = Position(x + _size.minX, y + _size.minX);
    if (!_size.withinBounds(offset)) {
      return;
    }

    _cursorPosition += offset;
    stdout.write("\x1b[${offset.y};${offset.x}H"); // Move cursor
  }

  // Custom erase screen for window
  void clear() {
    for (int y = 0; y < _size.height; y++) {
      moveCursorTo(0, y);
      stdout.write(" " * _size.width); // Overwrite with spaces
    }
  }

  void write(String msg, [int? x, int? y]) {
    // Either both are specified or none
    assert((x == null && y == null) || (x != null && y != null));
    if (x != null && y != null) {
      moveCursorTo(x, y);
    }

    final msgLen = msg.length;

    final newX = _cursorPosition.x + msgLen;
    final newY = _cursorPosition.y + (newX ~/ _size.width);

    // If printing this string will exceed the window's bounds
    if (newY > _size.maxY) {
      // Print character by character
      for (int i = 0; i < msg.length; i++) {
        // If we're at the end of the window
        if (_cursorPosition.x + 1 > _size.maxX) {
          // At this point, we are passed the window bounds
          if (_cursorPosition.y + 1 > _size.maxY) {
            break;
          } else { // We can go to the next line
            _cursorPosition = Position.y(_cursorPosition.y + 1);
          }
        }

        stdout.write(msg[i]);
        _cursorPosition += Position.x(1);
      }
    } else { // Else, print all at once
      stdout.write(msg);
      _cursorPosition = Position(newX % _size.width, newY);
    }
  }
}
