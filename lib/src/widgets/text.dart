import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/writer_object.dart';
import 'package:flutter_tui/src/stateless_widget.dart';

class Text extends StatelessWidget {
  final String text;

  Text(this.text);

  @override
  WriterObject build(Size constraint) {
    int textLen = text.length;
    int width = textLen % constraint.width;
    int height = textLen ~/ constraint.height;
    
    if (height > constraint.height) {
      // TODO: Handle overflow
    }

    return WriterObject(
      widgetKey: key,
      size: Size(width: width, height: height),
      text: text
    );
  }
}
