import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapes.dart';

void main() {
  test('ShapeJ can be constructed and is a shape', () {
    final shape = ShapeI();
    expect(
        shape.getAbsPositions(base: Position(10, 10)) is List<Position>, true);
    expect(
        shape.getRotatedAbsPositions(
            base: Position(10, 10), rotation: Rotation.left) is Shape,
        true);
  });
}
