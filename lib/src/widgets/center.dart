import 'package:flutter_tui/src/models/position.dart';
import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/writer_object.dart';
import 'package:flutter_tui/src/stateless_widget.dart';
import 'package:flutter_tui/src/widget.dart';

class Center extends StatelessWidget {
  final Widget child;

  Center({required this.child});

  @override
  WriterObject build(Size constraint) {
    final body = child.build(constraint);
    final w = body.size.width, h = body.size.height;

    return WriterObject(
      widgetKey: key,
      size: Size(
        start: Position(
          (constraint.width - w)  ~/ 2,
          (constraint.height - h) ~/ 2
        ),
        width: w,
        height: h
      ),
      text: body.text,
      children: [body]
    );
  }
}
