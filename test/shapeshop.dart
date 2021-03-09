import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/shapeshop.dart';

void main() {
  test('ShapeShop can be constructed', () {
    var shapeShop = ShapeShop();
    expect(shapeShop is ShapeShop, true);
  });
}
