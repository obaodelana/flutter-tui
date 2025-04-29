import 'package:flutter_tui/flutter_tui.dart';
import 'package:flutter_tui/src/widgets.dart';

void main(List<String> arguments) async {
  await runApp(Center(
    child: Column(
      mainAxisAlignment: AxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: AxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Text("Text ${i+1}")
          ]
        ),
        Row(
          mainAxisAlignment: AxisAlignment.center,
          crossAxisAlignment: AxisAlignment.center,
          children: [
            for (int i = 3; i < 3+3; i++)
              Text("Text ${i+1}")
          ]
        ),
        Row(
          mainAxisAlignment: AxisAlignment.center,
          crossAxisAlignment: AxisAlignment.end,
          children: [
            for (int i = 3+3; i < 3+3+3; i++)
              Text("Text ${i+1}")
          ]
        ),
      ]
    )
  ));
}
