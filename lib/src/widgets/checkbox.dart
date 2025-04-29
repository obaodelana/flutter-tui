import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/widgets.dart';

class Checkbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool)? onChanged;

  const Checkbox({
    required this.isChecked,
    this.onChanged
  });

  @override
  WriteObject createObject(Size constraint) {
    final checkBox = isChecked ? "x" : " ";

    return Text("[$checkBox] ")
      .createObject(constraint);
  }
}