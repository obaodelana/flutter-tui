import 'package:flutter_tui/src/widget.dart';
import 'package:flutter_tui/src/writer.dart';

abstract class StatefulWidget extends Widget {
  void setState(void Function() fn) {
    fn();
    Writer.instance.write(this);
  }
}
