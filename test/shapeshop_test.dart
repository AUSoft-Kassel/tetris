import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';

void main() {
  test('ShapeShop can be constructed', () {
    final shapeShop = ShapeShop();
    expect(shapeShop is ShapeShop, true);
  });

  test('ShapeShop.showShape returns a shape', () {
    final shapeShop = ShapeShop();
    final shape = shapeShop.showShape();
    expect(shape is Shape, true);
  });

  test('ShapeShop.showShape returns the same shape every time it runs', () {
    final shapeShop = ShapeShop();
    final shape1 = shapeShop.showShape();
    // ignore: avoid_redundant_argument_values
    final shape2 = shapeShop.showShape(
        0); // It should accept empty and 0, both for the first element
    expect(shape1 == shape2, true);
  });

  test(
      'ShapeShop.showShape returns 14 shapes in random order, and every piece is an individual',
      () {
    final shapeShop = ShapeShop();
    final shown = <Shape>[];
    for (var x = 0; x < 14; x++) {
      final shape = shapeShop.showShape(x);
      expect(shown.contains(shape), false);
      shown.add(shape);
    }
  });

  test(
      'ShapeShop.showShape alwas is able to show the next 14 pieces (but never more, by definition, otherwise we would have 14-28)',
      () {
    final shapeShop = ShapeShop();
    for (var x = 0; x < 100; x++) {
      final Shape? shape = shapeShop.showShape(x);
      if (x < 13) {
        expect(shape is Shape, true);
      } else {
        expect(shape == null, true);
      }
    }
  });

  test(
      'ShapeShop.showShape returns 14 shapes in random order, consisting of 2 pieces * 7 kinds of shapes',
      () {
    final shapeShop = ShapeShop();
    final map = <String, int>{};
    for (var x = 0; x < 14; x++) {
      final shape = shapeShop.showShape(x);
      final runtimeTypeName = shape.runtimeType.toString();
      map[runtimeTypeName] = (map[runtimeTypeName] ?? 0) + 1;
    }
    log('$map');
    expect(map.length, 7);
    map.forEach((key, value) {
      log('$key -> $value');
      expect(value, 2);
    });
  });

  test('giveShape returns a shape', () {
    final shapeShop = ShapeShop();
    final shape = shapeShop.giveShape();
    expect(shape is Shape, true);
  });

  test('giveShape returns always the shape that was shown before', () {
    final shapeShop = ShapeShop();
    for (var x = 0; x < 1000; x++) {
      final shapeShown = shapeShop.showShape();
      final shapeGiven = shapeShop.giveShape();
      expect(shapeShown == shapeGiven, true);
    }
  });

  test(
      'After giving out 14 shapes, ShapeShop.showShape returns 14 shapes in random order, consisting of 2 pieces * 7 kinds of shapes',
      () {
    final shapeShop = ShapeShop();
    for (var x = 0; x < 14; x++) {
      shapeShop.giveShape();
    }
    final map = <String, int>{};
    for (var x = 0; x < 14; x++) {
      final shape = shapeShop.showShape(x);
      final runtimeTypeName = shape.runtimeType.toString();
      map[runtimeTypeName] = (map[runtimeTypeName] ?? 0) + 1;
    }
    expect(map.length, 7);
    map.forEach((key, value) {
      expect(value, 2);
    });
  });
}
