import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/position.dart';

void main() {
  test('Positions can be constructed and read', () {
    final pos1 = Position(5, 10);
    final pos2 = Position(10, 2);
    expect(pos1.x, 5);
    expect(pos2.x, 10);
    expect(pos1.y, 10);
    expect(pos2.y, 2);
  });

  test('Two positions are equal to each other when they are the same', () {
    final pos1 = Position(5, 10);
    final pos2 = pos1;
    expect(pos1 == pos2, true);
  });

  test('Two positions are equal when their coordinates are the same', () {
    final pos1 = Position(5, 10);
    final pos2 = Position(5, 10);
    expect(pos1 == pos2, true);
  });
}
