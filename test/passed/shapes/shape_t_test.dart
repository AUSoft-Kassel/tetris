import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shapes.dart';

void main() {
  test('ShapeT can be constructed and is a shape', () {
    final shape = ShapeT();
    expect(shape.absPositions(base: Position(10, 10)) is List<Position>, true);
    expect(
        shape.absPositions(base: Position(10, 10), rotation: Rotation.left)
            is List<Position>,
        true);
  });
}
