import 'package:flutter_tui/src/context.dart';
import 'package:flutter_tui/src/models/render_object.dart';
import 'package:flutter_tui/src/stateless_widget.dart';

class Text extends StatelessWidget {
  final String text;

  const Text(this.text);

  @override
  RenderObject build(Window context) {
    return RenderObject(
      rect: (x:),
      text: text
    );
  }
}
