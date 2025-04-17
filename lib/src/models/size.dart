import 'package:flutter_tui/src/models/position.dart';

class Size {
  final Position start;
  final int width;
  final int height;

  const Size({required this.width, required this.height, Position? start})
   : start = start ?? const Position.zero();

  int get minX => start.x;
  int get maxX => width + start.x - 1;

  int get minY => start.y;
  int get maxY => height + start.y - 1;

  bool withinBounds(Position pos) {
    if (pos.x < minX || pos.x > maxX || pos.y < minY || pos.y > maxY) {
      return false;
    }
    return true;
  }

  @override
  bool operator==(covariant Size other) {
    return width == other.width
      && height == other.height
      && start == other.start;
  }

  @override
  int get hashCode => Object.hash(start, width, height);
}
