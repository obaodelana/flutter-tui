import 'package:flutter_tui/flutter_tui.dart';
import 'package:flutter_tui/src/widgets/center.dart';
import 'package:flutter_tui/src/widgets/row.dart';
import 'package:flutter_tui/src/widgets/text.dart';

void main(List<String> arguments) {
  runApp(Center(
    child: Row(
      children: [
        for (int i = 0; i < 5; i++)
          Text("${i+1}")
      ]
    )
  )
  );
}
