import 'package:flutter_tui/flutter_tui.dart';
import 'package:flutter_tui/src/widgets/center.dart';
import 'package:flutter_tui/src/widgets/column.dart';
import 'package:flutter_tui/src/widgets/text.dart';

void main(List<String> arguments) {
  runApp(Center(
    child: Column(
      children: [
        for (int i = 0; i < 7; i++)
          Center(child: Text("${i+1}"))
      ]
    )
  )
  );
}
