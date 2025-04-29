import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';

class Row extends StatelessWidget {
  final List<Widget> children;

  Row({required this.children});

  @override
  WriteObject createObject(Size constraint) {
    // Equal width
    int childWidth = constraint.width ~/ children.length;
    var maxChildHeight = 1;

    final sizedChildren = <WriteObject>[];
    for (int i = 0; i < children.length; i++) {
      var obj = children[i].createObject(Size(
        width: childWidth,
        height: constraint.height,
        start: Position.x(i * childWidth)
      ));
      sizedChildren.add(obj);

      if (obj.size.height > maxChildHeight) {
        maxChildHeight = obj.size.height;
      }
    }

    return WriteObject(
      size: constraint.copy(
        height: maxChildHeight,
        width: childWidth * children.length
      ),
      children: sizedChildren
    );
  }
}
