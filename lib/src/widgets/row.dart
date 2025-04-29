import 'package:flutter_tui/src/widgets/flex.dart';

class Row extends Flex {
  Row({
    required super.children,
    super.direction = Axis.horizontal,
    super.mainAxisAlignment = AxisAlignment.start,
    super.crossAxisAlignment = AxisAlignment.start,
  });
}
