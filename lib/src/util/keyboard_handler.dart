import 'dart:io';

typedef OnKeyPress = void Function(String);

class KeyboardHandler {
  static KeyboardHandler? _instance;
  static KeyboardHandler get instance => _instance ?? KeyboardHandler._();

  final _listeners = <OnKeyPress>[];

  KeyboardHandler._() {
    stdin.listen((List<int> bytes) {
      if (bytes.isNotEmpty) {
        _keyPress(bytes);
      }
    });
  }

  String _bytesToString(List<int> bytes) {
    String key = "";
    if (bytes.length == 1) {
      final byte = bytes.first;
      // Print characters
      if (byte >= 32 && byte <= 126) {
        key = String.fromCharCode(byte);
      } else if ((byte >= 8 && byte <= 13) || byte == 127) {
        final mapping = {
          8: "\b", 9: "\t",
          10: "\n", 11: "\v",
          12: "\f", 13: "\r",
          127: "delete"
        };
        key = mapping[byte] ?? "";
      } else {
        // TODO: Handle other keys
      }
    // Arrow keys
    } else if (bytes.length == 3 && bytes[0] == 27 && bytes[1] == 91) {
      final mapping = {
        65: "up", 66: "down",
        67: "right", 68: "left"
      };
      key = mapping[bytes[2]] ?? "";
    }

    File("log.txt")
      ..writeAsStringSync("$bytes ", mode: FileMode.append)
      ..writeAsStringSync("$key\n", mode: FileMode.append);
    return key;
  }

  void _keyPress(List<int> bytes) {
    String key = _bytesToString(bytes);
    for (final listener in _listeners) {
      listener(key);
    }
  }

  void addListener(OnKeyPress listener) {
    _listeners.add(listener);
  }

  void removeAllListeners() {
    _listeners.clear();
  }
}