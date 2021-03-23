import 'package:flutter/material.dart';
import 'package:tetris/models/shapes.dart';

import 'position.dart';
import 'shapeform.dart';
import 'shapeform.dart';

abstract class Shape {
  abstract final Position _anchorPosition;
  abstract int _currentShapeState;
  abstract final List<List<Position>> _shapeStates;
  abstract final Color _color;

  Shape();

  factory Shape.fromForm(ShapeForm form) {
    if (form == ShapeForm.i) return ShapeI();
    if (form == ShapeForm.j) return ShapeJ();
    if (form == ShapeForm.l) return ShapeL();
    if (form == ShapeForm.z) return ShapeZ();
    if (form == ShapeForm.s) return ShapeS();
    if (form == ShapeForm.t) return ShapeT();
    return ShapeO();
  }

  void rotateRight() {
    if (_currentShapeState >= _shapeStates.length) {
      _currentShapeState = 0;
    } else {
      _currentShapeState++;
    }
  }

  void rotateLeft() {
    if (_currentShapeState <= 0) {
      _currentShapeState = _shapeStates.length;
    } else {
      _currentShapeState++;
    }
  }
}
