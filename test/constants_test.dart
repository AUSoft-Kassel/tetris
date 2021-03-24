import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/constants.dart';

void main() {
  test('Constants can be read and have the expected value', () {
    expect(Constants.numRows, 20);
    expect(Constants.numRows is int, true);
    expect(Constants.numCols, 10);
    expect(Constants.numCols is int, true);
    expect(Constants.minSpeed, 10.0);
    expect(Constants.minSpeed is double, true);
    expect(Constants.maxSpeed, 100.0);
    expect(Constants.maxSpeed is double, true);
  });
}
