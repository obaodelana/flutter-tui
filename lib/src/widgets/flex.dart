import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/widgets/align.dart';

enum Axis { horizontal, vertical }

enum AxisAlignment {
  start(0),
  center(0.5),
  end(1);

  final double value;

  const AxisAlignment(this.value);
}

abstract class Flex extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final AxisAlignment mainAxisAlignment, crossAxisAlignment;

  Flex({
    required this.children,
    required this.direction,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment
  }) : assert(children.isNotEmpty);

  @override
  WriteObject createObject(Size constraint) {
    bool hor = (direction == Axis.horizontal);

    // Equal width
    // TODO: Use proper layout algorithm (i.e., don't always assume equal width)
    final mainAxisSize =
      (hor ? constraint.width : constraint.height)
      ~/ children.length;
    var maxCrossAxisSize = 1;

    final sizedChildren = <WriteObject>[];
    for (int i = 0; i < children.length; i++) {
      var obj = Align(
        alignment: _getAlignment(),
        child: children[i]
      ).createObject(Size(
        width: hor ? mainAxisSize : constraint.width,
        height: hor ? constraint.height : mainAxisSize,
        start: hor ? Position.x(i * mainAxisSize) : Position.y(i * mainAxisSize),
      ));
      sizedChildren.add(obj);

      final crossAxisSize = hor ? obj.size.height : obj.size.width;
      if (crossAxisSize > maxCrossAxisSize) {
        maxCrossAxisSize = crossAxisSize;
      }
    }

    return WriteObject(
      size: constraint.copy(
        width: hor
          ? mainAxisSize * children.length
          : maxCrossAxisSize,
        height: hor
          ? maxCrossAxisSize
          : mainAxisSize * children.length,
      ),
      children: sizedChildren
    );
  }

  Alignment _getAlignment() {
    if (direction == Axis.horizontal) {
      return Alignment(mainAxisAlignment.value, crossAxisAlignment.value);
    } else {
      return Alignment(crossAxisAlignment.value, mainAxisAlignment.value);
    }
  }
}
