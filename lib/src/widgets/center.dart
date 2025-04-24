import 'package:flutter_tui/src/models.dart';
import 'package:flutter_tui/src/framework.dart';
import 'package:flutter_tui/src/widgets.dart';

class Center extends StatelessWidget {
  final Widget child;

  Center({required this.child});

  @override
  WriteObject build(Size constraint) {
    return Align(
      child: child,
      alignment: Alignment.center
    ).build(constraint);
  }
}
