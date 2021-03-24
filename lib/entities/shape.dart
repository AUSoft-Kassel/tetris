import 'package:flutter/material.dart';
import 'package:tetris/entities/shapes.dart';
import 'package:tetris/entities/rotation.dart';

import 'position.dart';
import 'shapeform.dart';

///Descriptes a abstract class for our Shapes.
abstract class Shape {
  abstract int _currentShapeState;
  abstract final List<List<Position>> _shapeStates;
  abstract final Color _color;

  ///Our game object
  Shape();

  ///Descriptes which form we need.
  factory Shape.fromForm(ShapeForm form) {
    if (form == ShapeForm.i) return ShapeI();
    if (form == ShapeForm.j) return ShapeJ();
    if (form == ShapeForm.l) return ShapeL();
    if (form == ShapeForm.z) return ShapeZ();
    if (form == ShapeForm.s) return ShapeS();
    if (form == ShapeForm.t) return ShapeT();
    return ShapeO();
  }

  /// Descriptes the rotation of a shape to the right side.
  void rotateRight() {
    if (_currentShapeState >= _shapeStates.length) {
      _currentShapeState = 0;
    } else {
      _currentShapeState++;
    }
  }

  /// Descriptes the rotation of a shape to the left side.
  void rotateLeft() {
    if (_currentShapeState <= 0) {
      _currentShapeState = _shapeStates.length;
    } else {
      _currentShapeState++;
    }
  }
}
