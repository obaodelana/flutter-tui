import 'package:flutter_tui/src/models/render_object.dart';
import 'package:flutter_tui/src/window.dart';

class Writer {
  static Writer? _instance;
  static Writer get instance => (_instance ??= Writer._());

  // Private constructor
  Writer._();

  void write(RenderObject obj, [RenderObject? oldObj]) {
    // No change to render object
    if (oldObj == obj) {
      return;
    }

    Window window = Window(size: obj.rect);
    window.write(obj.text);
  }
}
