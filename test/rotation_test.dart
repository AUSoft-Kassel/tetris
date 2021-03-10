import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/gamestatus.dart';
import 'package:tetris/models/rotation.dart';

void main() {
  test('Rotation can be constructed and read', () {
    const left = Rotation.left;
    const right = Rotation.right;
    expect(left is GameStatus, true);
    expect(right is GameStatus, true);
  });
}
