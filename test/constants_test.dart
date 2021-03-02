import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/services/constants.dart';

void main() {
  test('Constants can be read and have the expected value', () {
    expect(Constants.numRows, 20);
    expect(Constants.numCols, 10);
  });
}
