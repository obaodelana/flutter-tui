import 'package:flutter_tui/src/models/position.dart';

class Size {
  final Position start;
  final int width;
  final int height;

  const Size({required this.width, required this.height, Position? start})
   : start = start ?? const Position.zero();

  Size copy({int? width, int? height, Position? start}) {
    return Size(
      width: width ?? this.width,
      height: height ?? this.height,
      start: start ?? this.start
    );
  }

  int get minX => start.x;
  int get maxX => width + start.x;

  int get minY => start.y;
  int get maxY => height + start.y;

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

  @override
  String toString() {
    return "Size(\n"
            "start: $start\n,"
            "width: $width\n,"
            "height: $height\n"
            ");";
  }
}
