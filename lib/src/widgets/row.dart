import 'package:flutter_tui/src/models/position.dart';
import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';
import 'package:flutter_tui/src/framework.dart';

class Row extends StatelessWidget {
  final List<Widget> children;

  Row({required this.children});

  @override
  WriteObject build(Size constraint) {
    // Equal width
    final childWidth = constraint.width ~/ children.length;

    return WriteObject(
      size: constraint,
      children: [
        for (int i = 0; i < children.length; i++)
          children[i].build(Size(
            width: childWidth,
            height: constraint.height,
            start: constraint.start + Position.x(i * childWidth)
          ))
      ]
    );
  }
}
