import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';

class Text extends StatelessWidget {
  final String text;

  Text(this.text);

  @override
  WriteObject createObject(Size constraint) {
    int textLen = text.length;
    int width = textLen % constraint.width;
    int height = (textLen / constraint.height).ceil();
    
    if (height > constraint.height) {
      // TODO: Handle overflow
    }

    return WriteObject(
      size: constraint.copy(width: width, height: height),
      text: text
    );
  }
}
