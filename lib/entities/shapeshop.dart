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
    var shapesToShow = <Shape>[];
    shapesToShow = _currentBag;
    for (var i = 0; shapesToShow.length < 14; i++) {
      shapesToShow.add(_nextBag[i]);
    }
    return shapesToShow[x];
  }
}
