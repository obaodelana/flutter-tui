import 'package:meta/meta.dart';

import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/render_object.dart';

abstract class Widget {
  @protected
  Size? size;
  @protected
  RenderObject? lastBuild;

  RenderObject build(Size constraint);

  bool didUpdateWidget(Widget oldWidget) {
    return oldWidget.lastBuild == lastBuild;
  }
}
