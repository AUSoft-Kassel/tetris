import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/direction.dart';

void main() {
  test('Directions can be constructed and read', () {
    const down = Direction.down;
    const up = Direction.up;
    const left = Direction.left;
    const right = Direction.right;
    expect(down is Direction, true);
    expect(up is Direction, true);
    expect(right is Direction, true);
    expect(left is Direction, true);
  });
}
