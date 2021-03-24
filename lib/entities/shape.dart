import 'package:flutter/material.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shapeform.dart';
import 'package:tetris/entities/shapes.dart';
import 'package:tetris/entities/rotation.dart';

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

  /// Rotate a shape.
  void rotateShape(Rotation rotation) {
    _currentShapeState = getNewShapeState(rotation);
  }

  /// Gets the new State after rotating
  int getNewShapeState(Rotation rotation) {
    var newShapeState = _currentShapeState;
    if (rotation == Rotation.right) {
      if (_currentShapeState >= _shapeStates.length) {
        newShapeState = 0;
      } else {
        newShapeState++;
      }
    }
    if (rotation == Rotation.left) {
      if (_currentShapeState <= 0) {
        newShapeState = _shapeStates.length;
      } else {
        newShapeState++;
      }
    }
    return newShapeState;
  }

  ///Gets Absolut Positions of the current State
  List<Position> getAbsPositions(Position base) {
    final List<Position> absPositions = [];
    for (var relPosition in _shapeStates[_currentShapeState]) {
      absPositions.add(base + relPosition);
    }
    return absPositions;
  }

  ///Gets Absolut Positions of the rotated State
  List<Position> getRotatedAbsPositions(Position base, Rotation rotation) {
    final List<Position> absPositions = [];
    for (var relPosition in _shapeStates[getNewShapeState(rotation)]) {
      absPositions.add(base + relPosition);
    }
    return absPositions;
  }
}
