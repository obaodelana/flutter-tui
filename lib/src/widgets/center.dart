import 'package:flutter_tui/src/context.dart';
import 'package:flutter_tui/src/models/render_object.dart';
import 'package:flutter_tui/src/stateless_widget.dart';
import 'package:flutter_tui/src/widget.dart';

class Center extends StatelessWidget {
  final Widget child;

  const Center({required this.child});

  @override
  RenderObject build(Window context) {
    final body = child.build(context);

    return RenderObject(
      rect: (
        x: (context.width - body.rect.w)  ~/ 2,
        y: context.height ~/ 2,
        w: body.rect.w,
        h: body.rect.h
      ),
      text: body.text
    );
  }
}
