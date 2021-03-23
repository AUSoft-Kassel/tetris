import 'dart:math';

import 'package:tetris/models/shapes.dart';

import 'shape.dart';
import 'shapeform.dart';

class ShapeShop {
  List<Shape> _currentBag = [];
  List<Shape> _nextBag = [];

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

  Shape showShape([int x = 0]) {

    if()

    return _currentBag[x];
    return _nextBag[x];
  }
}
