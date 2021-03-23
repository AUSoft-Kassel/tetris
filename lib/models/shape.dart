import 'package:flutter/material.dart';

import 'position.dart';

abstract class Shape {
  Position? _anchorPosition;

  abstract int _currentShapeState;
  abstract final List<List<Position>> _shapeStates;
  abstract final Color _color;

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
