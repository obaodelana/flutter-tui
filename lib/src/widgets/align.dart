import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';

// A point within a rectangle of dimension 1x1.
class Alignment {
  final double x, y;

  const Alignment(this.x, this.y)
    : assert(x >= 0.0 && x <= 1.0),
      assert(y >= 0.0 && y <= 1.0);

  static const
    bottomCenter = Alignment(0.5, 1),
    bottomLeft = Alignment(0, 1),
    bottomRight = Alignment(1, 1),
    center = Alignment(0.5, 0.5),
    centerLeft = Alignment(0, 0.5),
    centerRight = Alignment(1, 0.5),
    topCenter = Alignment(0.5, 0),
    topLeft = Alignment(0, 0),
    topRight = Alignment(1, 0);
}

class Align extends StatelessWidget {
  final Widget child;
  final Alignment alignment;

  Align({required this.alignment, required this.child});

  @override
  WriteObject createObject(Size constraint) {
    final body = child.createObject(constraint);
    final w = body.size.width, h = body.size.height;

    // Align child
    body.size = body.size.copy(
      start: Position(
        ((constraint.width - w) * alignment.x).ceil(),
        ((constraint.height - h) * alignment.y).ceil()
      ),
    );

    return WriteObject(
      size: constraint,
      children: [body]
    );
  }
}
