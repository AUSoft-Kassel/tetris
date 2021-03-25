import 'package:flutter/material.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shapeform.dart';
import 'package:tetris/entities/shapes.dart';
import 'package:tetris/entities/rotation.dart';

///Descriptes a abstract class for our Shapes.
abstract class Shape {
  abstract int _currentShapeStateId;
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
    _currentShapeStateId = getNewShapeState(rotation);
  }

  List<Position> getCurrentShapeState(){
    return _shapeStates[_currentShapeStateId];
  }

  /// Gets the new State after rotating
  int getNewShapeState(Rotation rotation) {
    var newShapeState = _currentShapeState;
    if (rotation == Rotation.right) {
      if (_currentShapeStateId >= _shapeStates.length) {
        newShapeState = 0;
      } else {
        newShapeState++;
      }
    }
    if (rotation == Rotation.left) {
      if (_currentShapeStateId <= 0) {
        newShapeState = _shapeStates.length;
      } else {
        newShapeState++;
      }
    }
    return newShapeState;
  }

  ///Gets Absolut Positions of the currend or rotated State

  List<Position> getAbsPositions({required Position base, Rotation rotation = Rotation.none}) {
    final List<Position> absPositions = [];
    for (var relPosition in _shapeStates[getNewShapeState(rotation)]) {
      absPositions.add(base + relPosition);
    }
    return absPositions;
  }
}
