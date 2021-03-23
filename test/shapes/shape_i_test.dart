import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/position.dart';
import 'package:tetris/models/rotation.dart';
import 'package:tetris/models/shape.dart';
import 'package:tetris/models/shape_i.dart';

void main() {
  test('ShapeI can be constructed and is a shape', () {
    var shape = ShapeI();
    expect(shape.getAbsPositions(base: Position(10, 10)) is List<Position>, true);
    expect(shape.getRotatedAbsPositions(base: Position(10, 10), rotation: Rotation.left) is Shape, true);
  });
}