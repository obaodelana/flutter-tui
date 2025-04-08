import 'package:flutter_tui/src/context.dart';
import 'package:flutter_tui/src/widget.dart';

class Center implements Widget {
  final Widget child;

  const Center({required this.child});

  @override
  String build(Context context) {
    final body = child.build(context);
    final bodyWidth = body.length;

    context.moveCursorTo((context.width - bodyWidth)  ~/ 2, context.height ~/ 2);
    return body;
  }
  
  @override
  bool didUpdateWidget() {
    return child.didUpdateWidget();
  }
}