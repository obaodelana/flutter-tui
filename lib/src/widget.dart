import 'package:flutter_tui/src/context.dart';

abstract class Widget {
  String build(Context context);
  bool didUpdateWidget(); // TODO: Include old widget
}