import 'dart:math';

import 'shape.dart';
import 'shapeform.dart';

/// ShapeShop is our Shop which is storing shapes and preparing them for the game.
class ShapeShop {
  List<Shape> _currentBag = [];
  List<Shape> _nextBag = [];

  /// Holds the currently used bag of max. 14 shapes
  List<Shape> get currentBag => _currentBag;

  /// Holds the next used bag of 14 shapes (which will be used after currentBag ist emtied)
  List<Shape> get nextBag => _nextBag;

  ///Descriptes a function which is filling our bag with shapes.
  ShapeShop() {
    _fillBag(_currentBag);
    _fillBag(_nextBag);
  }

  void _fillBag(List<Shape> fillBag) {
    var bag = <Shape>[];
    final rng = Random(); // Random();
    for (var form in ShapeForm.values) {
      bag = [...bag, Shape.fromForm(form), Shape.fromForm(form)];
    }
    while (bag.isNotEmpty) {
      final n = rng.nextInt(bag.length); //rng.nextInt(bag.length);
      fillBag.add(bag[n]);
      bag.removeAt(n);
    }
  }

  /// Descriptes a function which is giving us the next game shape, and auto-fill the currentBag from the nextBag which get filled by RNG if empty.
  Shape giveShape() {
    // dev.log(
    //     'giveShape vorher: current: ${_currentBag.length}, next: ${_nextBag.length}');
    final shape = _currentBag[0];
    _currentBag.removeAt(0);
    if (_currentBag.isEmpty) {
      _currentBag = [..._nextBag];
      _nextBag = [];
      _fillBag(_nextBag);
    }
    // dev.log(
    //     'giveShape nachher: current: ${_currentBag.length}, next: ${_nextBag.length}');
    return shape;
  }

  /// Is going to show us the next 14 Shapes at any time if code done
  Shape showShape([int x = 0]) {
    var shapesToShow = <Shape>[];
    shapesToShow = [..._currentBag];
    for (var i = 0; shapesToShow.length < 14; i++) {
      shapesToShow.add(_nextBag[i]);
    }
    return shapesToShow[x];
  }
}
