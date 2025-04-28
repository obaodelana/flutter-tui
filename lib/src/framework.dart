import 'package:meta/meta.dart';

import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';

abstract class Writable {
  WriteObject build(Size constraint);
}

abstract class Widget implements Writable {
  const Widget();
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget();
}

abstract class StatefulWidget extends Widget {
  late final State _state;

  StatefulWidget() {
    _state = createState();
    _state.widget = this;
  }

  @protected
  State createState();

  @override
  WriteObject build(Size constraint) {
    return _state.build(constraint);
  }
}

abstract class State<T extends StatefulWidget> implements Writable {
  T? _widget;

  T? get widget => _widget;
  set widget(T? widget) => _widget ??= widget;
}
