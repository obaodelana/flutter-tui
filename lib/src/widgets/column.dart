import 'package:flutter_tui/src/widgets/flex.dart';

class Column extends Flex {
  Column({
    required super.children,
    super.direction = Axis.vertical,
    super.mainAxisAlignment = AxisAlignment.start,
    super.crossAxisAlignment = AxisAlignment.start,
  });
}
