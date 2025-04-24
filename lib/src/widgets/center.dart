import 'package:flutter_tui/src/models/position.dart';
import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';
import 'package:flutter_tui/src/framework.dart';

class Center extends StatelessWidget {
  final Widget child;

  Center({required this.child});

  @override
  WriteObject build(Size constraint) {
    final body = child.build(constraint);
    final w = body.size.width, h = body.size.height;

    // Center child
    body.size = body.size.copy(
      start: Position(
        (constraint.width - w)  ~/ 2,
        (constraint.height - h) ~/ 2
      )
    );

    return WriteObject(
      size: constraint,
      children: [body]
    );
  }
}
