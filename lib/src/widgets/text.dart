import 'package:flutter_tui/src/context.dart';
import 'package:flutter_tui/src/widget.dart';

class Text implements Widget {
  final String text;

  const Text(this.text);

  @override
  String build(Context context) {
    return text;
  }
  
  @override
  bool didUpdateWidget() {
    return false;
  }
}