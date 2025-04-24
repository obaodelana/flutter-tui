import 'package:flutter_tui/src/models/position.dart';
import 'package:flutter_tui/src/models/size.dart';
import 'package:test/test.dart';

void main() {
  group("Test different edge cases for withinBounds method", () {
    test("Normal: Position is within bounds", () {
      final size = Size(width: 80, height: 24);

      final pos = Position(40, 12);
      expect(size.withinBounds(pos), true);
    });

    test("Edge: Position is exactly on edge", () {
      final size = Size(width: 10, height: 10);

      final pos1 = Position(0, 0);
      final pos2 = Position(10, 10);
      final pos3 = Position(9, 9);

      expect(size.withinBounds(pos1), true);
      expect(size.withinBounds(pos2), true);
      expect(size.withinBounds(pos3), true);
    });

    test("Out of bounds", () {
      final size1 = Size(width: 80, height: 24);
      final size2 = Size(width: 80, height: 14, start: Position(10, 10));

      final pos1 = Position(0, 0);
      expect(size1.withinBounds(pos1), true);
      expect(size2.withinBounds(pos1), false);

      final pos2 = Position(10, 10);
      expect(size1.withinBounds(pos2), true);
      expect(size2.withinBounds(pos2), true);

      final pos3 = Position(90, 24);
      expect(size1.withinBounds(pos3), false);
      expect(size2.withinBounds(pos3), true);
    });

    test("Using a non-zero start", () {
      final size = Size(width: 13, height: 1, start: Position(33, 11));

      final pos = Position(33, 11);
      expect(size.withinBounds(pos), true);
    });
  });
}