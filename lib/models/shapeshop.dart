import 'shape.dart';

class ShapeShop {
  List<Shape> bag = [];

  void fillBag() {}

  Shape showShape([int x = 0]) {
    if (bag.isEmpty) {
      fillBag();
    }
    return bag[x];
  }
}
