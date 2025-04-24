import 'package:flutter_tui/src/models/position.dart';
import 'package:flutter_tui/src/models/size.dart';

// Represents a window. Doesn't print directly to stdout
class Window {
  final Size _size;
  Size get size => _size;

  Position _cursorPosition;

  Window({required Size size}) : _size = size, _cursorPosition = size.start;

  String _moveCursorTo(Position pos) {
    if (!_size.withinBounds(pos)) {
      return "";
    }

    _cursorPosition = pos;
    return "\x1b[${pos.y};${pos.x}H"; // Move cursor
  }

  String moveCursorTo(int x, int y) {
    Position pos = Position(x + _size.minX, y + _size.minY);
    return _moveCursorTo(pos);
  }

  // Custom erase screen for window
  List<String> clear() {
    final clearSequence = <String>[];
    for (int y = 0; y < _size.height; y++) {
      clearSequence.add(moveCursorTo(0, y));
      clearSequence.add(" " * _size.width); // Overwrite with spaces
    }

    // Reset cursor
    clearSequence.add(moveCursorTo(0, 0));

    return clearSequence;
  }

  List<String> write(String msg, [int? x, int? y]) {
    // Either both are specified or none
    assert((x == null && y == null) || (x != null && y != null));

    final writeSequence = <String>[];

    if (x != null && y != null) {
      writeSequence.add(moveCursorTo(x, y));
    } else {
      // Make sure cursor is at the correct position
      writeSequence.add(_moveCursorTo(_cursorPosition));
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

        writeSequence.add(msg[i]);
        _cursorPosition += Position.x(1);
      }
    } else { // Else, print all at once
      writeSequence.add(msg);
      _cursorPosition = Position(newX % _size.width, newY);
    }

    return writeSequence;
  }

  @override
  String toString() {
    return "Window(\n"
      "\tsize: $size,\n"
      "\tcursorPosition: $_cursorPosition\n"
      ");";
  }
}
