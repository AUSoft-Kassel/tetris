import 'dart:math';

import 'shape.dart';
import 'shapeform.dart';

///Descriptes the class ShapeShop which is our Shop which is shuffeling the next game objects and preparing them for the game.
class ShapeShop {
  List<Shape> _currentBag = [];
  List<Shape> _nextBag = [];

  ///Descriptes a function which is filling our bag with shapes.
  ShapeShop() {
    _fillBag(_currentBag);
    _fillBag(_nextBag);
  }

  void _fillBag(List<Shape> fillBag) {
    var bag = <Shape>[];
    final rng = Random();
    for (var form in ShapeForm.values) {
      bag = [...bag, Shape.fromForm(form), Shape.fromForm(form)];
    }
    while (bag.isNotEmpty) {
      final n = rng.nextInt(bag.length);
      fillBag.add(bag[n]);
      bag.removeAt(n);
    }
  }

  /// Descriptes a function which is giving us the next game shape, and auto-fill the currentBag from the nextBag which get filled by RNG if empty.
  Shape giveShape() {
    final shape = _currentBag[0];
    _currentBag.removeAt(0);
    if (_currentBag.isEmpty) {
      _currentBag = _nextBag;
      _nextBag = [];
      _fillBag(_nextBag);
    }
    return shape;
  }

  /// Is going to show us the next 14 Shapes at any time if code done
  Shape showShape([int x = 0]) {
    final List<Shape> shapesToShow = [];
    for (int i = 0; i < 14; i++) {
      if (i <= _currentBag.length - 1) {
        shapesToShow.add(_currentBag[i]);
      } else {
        shapesToShow.add(_nextBag[i - (_currentBag.length)]);
      }
    }
    return shapesToShow[x];
  }
}
