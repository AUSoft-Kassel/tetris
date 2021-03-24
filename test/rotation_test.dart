import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/rotation.dart';

void main() {
  test('Rotation can be constructed and read', () {
    const left = Rotation.left;
    const right = Rotation.right;
    expect(left is Rotation, true);
    expect(right is Rotation, true);
  });
}
