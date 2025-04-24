import 'package:flutter_tui/flutter_tui.dart';
import 'package:flutter_tui/src/widgets.dart';

void main(List<String> arguments) {
  runApp(Align(
    alignment: Alignment.centerRight,
    child: Column(
      children: [
        for (int i = 0; i < 7; i++)
          Text("${i+1}")
      ]
    )
  )
  );
}
