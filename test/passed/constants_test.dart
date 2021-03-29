import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/constant.dart';

void main() {
  test('Constants can be read and have the expected value', () {
    expect(Constant.numRows, 20);
    expect(Constant.numRows is int, true);
    expect(Constant.numCols, 10);
    expect(Constant.numCols is int, true);
    expect(Constant.minSpeed, 10.0);
    expect(Constant.minSpeed is double, true);
    expect(Constant.maxSpeed, 100.0);
    expect(Constant.maxSpeed is double, true);
  });
}
