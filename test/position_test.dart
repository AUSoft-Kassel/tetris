import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/positions.dart';

void main() {
  test('Positions can be constructed and read', () {
    final pos1 = Position(5, 10);
    final pos2 = Position(10, 2);
    expect(pos1.x, 5);
    expect(pos2.x, 10);
    expect(pos1.y, 10);
    expect(pos2.y, 2);
  });

  test('Positions can be constructed with an integer y and return integer and double y', () {
    final pos = Position(5, 10);
    expect(pos.x, 5);
    expect(pos.y, 10);
    expect(pos.yExact, 10.0);
  });

  test('Positions can be constructed with a double y and return integer and double y', () {
    final pos = Position.exact(5, 10.0);
    expect(pos.x, 5);
    expect(pos.y, 10);
    expect(pos.yExact, 10.0);
  });

  test('If provided with an exact y, integer y should be rounded', () {
    final pos1 = Position.exact(5, 9.6);
    expect(pos1.x, 5);
    expect(pos1.y, 10);
    expect(pos1.yExact, 9.6);
    final pos2 = Position.exact(5, 9.4);
    expect(pos2.x, 5);
    expect(pos2.y, 9);
    expect(pos2.yExact, 9.4);
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

  test('Two positions are equal when their rounded coordinates are the same', () {
    final pos1 = Position.exact(5, 3.4);
    final pos2 = Position.exact(5, 2.7);
    expect(pos1 == pos2, true);
  });
}
