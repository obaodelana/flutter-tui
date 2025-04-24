class Position {
  final int x, y;

  const Position(this.x, this.y);

  const Position.zero(): x = 0, y = 0;

  const Position.x(this.x) : y = 0;
  const Position.y(this.y) : x = 0;

  Position operator+(covariant Position other) {
    return Position(x + other.x, y + other.y);
  }

  @override
  bool operator ==(covariant Position other) {
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() {
    return "Position($x, $y);";
  }
}
