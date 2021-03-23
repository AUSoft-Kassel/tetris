import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/shape.dart';
import 'package:tetris/models/shapeshop.dart';

void main() {
  test('ShapeShop can be constructed', () {
    var shapeShop = ShapeShop();
    expect(shapeShop is ShapeShop, true);
  });

  test('ShapeShop.showShape returns a shape', () {
    var shapeShop = ShapeShop();
    var shape = shapeShop.showShape();
    expect(shape is Shape, true);
  });

  test('ShapeShop.showShape returns the same shape every time it runs', () {
    var shapeShop = ShapeShop();
    var shape1 = shapeShop.showShape();
    var shape2 = shapeShop.showShape(
        0); // It should accept empty and 0, both for the first element
    expect(shape1 == shape2, true);
  });

  // test('ShapeShop.showShape returns 14 shapes in random order, and every piece is an individual', () {
  //   var shapeShop = ShapeShop();
  //   var shown = List<Shape>[];
  //   for (var x = 0; x < 14; x++) {
  //     var shape = shapeShop.showShape(x);
  //     expect(shown.contains(shape), false);
  //     shown.add(shape);
  //   }
  // });

  // test('ShapeShop.showShape alwas is able to show the next 14 pieces (but never more, by definition, otherwise we would have 14-28)', () {
  //   var shapeShop = ShapeShop();
  //   var shown = List<Shape>[];
  //   for (var x = 0; x < 100; x++) {
  //     var shape = shapeShop.showShape(x);
  //     if (x < 14) {
  //       expect(shape is Shape, true);
  //     else {
  //       expect(shape ==null, true);
  //     }
  //   }
  // }});

  // test('ShapeShop.showShape returns 14 shapes in random order, consisting of 2 pieces * 7 kinds of shapes', () {
  //   var shapeShop = ShapeShop();
  //   var shown = List<Shape>[];
  //   Map <String, int> map = {};
  //   for (var x = 0; x < 14; x++) {
  //     var shape = shapeShop.showShape(x);
  //     var runtimeTypeName = shape.runtimeType.toString();
  //     map[runtimeTypeName] = map[runtimeTypeName] ?? 0 + 1;
  //   }
  //   expect(map.length,7);
  //   map.forEach((key, value) {
  //     expect(value,2);
  //   });
  // });

  // test('giveShape returns a shape', () {
  //   var shapeShop = ShapeShop();
  //   var shape=  shapeShop.giveShape();
  //   expect(shape is Shape, true);
  // });

  // test('giveShape returns always the shape that was shown before', () {
  //   var shapeShop = ShapeShop();
  //   for (var x = 0; x < 100; x++) {
  //     var shapeShown = shapeShop.showShape();
  //     var shapeGiven = shapeShop.giveShape();
  //     expect(shapeShown == shapeGiven, true);
  //   }
  // });

  // test('After giving out 14 shapes, ShapeShop.showShape returns 14 shapes in random order, consisting of 2 pieces * 7 kinds of shapes', () {
  //   var shapeShop = ShapeShop();
  //   var shown = List<Shape>[];
  //   for (var x = 0; x < 14; x++){
  //     shapeShop.giveShape();
  //   }
  //   Map <String, int> map = {};
  //   for (var x = 0; x < 14; x++) {
  //     var shape = shapeShop.showShape(x);
  //     var runtimeTypeName = shape.runtimeType.toString();
  //     map[runtimeTypeName] = map[runtimeTypeName] ?? 0 + 1;
  //   }
  //   expect(map.length,7);
  //   map.forEach((key, value) {
  //     expect(value,2);
  //   });
  // });
}
