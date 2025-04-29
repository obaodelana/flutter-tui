import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';

class Column extends StatelessWidget {
  final List<Widget> children;

  Column({required this.children});

  @override
  WriteObject createObject(Size constraint) {
    // Equal height
    int childHeight = constraint.height ~/ children.length;
    var maxChildWidth = 1;

    final sizedChildren = <WriteObject>[];
    for (int i = 0; i < children.length; i++) {
      var obj = children[i].createObject(Size(
        width: constraint.width,
        height: childHeight,
        start: Position.y(i * childHeight)
      ));
      sizedChildren.add(obj);

      if (obj.size.width > maxChildWidth) {
        maxChildWidth = obj.size.width;
      }
    }
    
    return WriteObject(
      size: constraint.copy(
        width: maxChildWidth,
        height: childHeight * children.length
      ),
      children: sizedChildren
    );
  }
}
