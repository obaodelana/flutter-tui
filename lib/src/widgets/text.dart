import 'package:flutter_tui/src/models/size.dart';
import 'package:flutter_tui/src/models/write_object.dart';
import 'package:flutter_tui/src/framework.dart';

class Text extends StatelessWidget {
  final String text;

  Text(this.text);

  @override
  WriteObject build(Size constraint) {
    int textLen = text.length;
    int width = textLen % constraint.width;
    int height = (textLen / constraint.height).ceil();
    
    if (height > constraint.height) {
      // TODO: Handle overflow
    }

    return WriteObject(
      size: Size(width: width, height: height),
      text: text
    );
  }
}
