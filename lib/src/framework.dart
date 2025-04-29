import 'package:flutter_tui/src/util/writer.dart';
import 'package:meta/meta.dart';

import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';

abstract class Writable {
  WriteObject createObject(Size constraint);
}

abstract class Widget implements Writable {
  const Widget();

  WriteObject build(Size constraint) {
    WriteObject object = createObject(constraint);

    Writer.instance.registerWidget(this, object);

    return object;
  }
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget();
}

// TODO: Finish implementing stateful widget
abstract class StatefulWidget extends Widget {
  late final State _state;

  StatefulWidget() {
    _state = createState();
    _state.widget = this;
  }

  @protected
  State createState();

  @override
  WriteObject createObject(Size constraint) {
    return _state.createObject(constraint);
  }
}

abstract class State<T extends StatefulWidget> implements Writable {
  T? _widget;

  T? get widget => _widget;
  set widget(T? widget) => _widget ??= widget;

  @protected
  void setState(void Function() fn) {
    if (_widget == null) {
      throw Exception("State is not attached to a widget");
    }

    fn();
    Writer.instance.update(_widget!);
  }
}
