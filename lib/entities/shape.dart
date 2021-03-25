import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shapeform.dart';
import 'package:tetris/entities/shapes.dart';
import 'package:tetris/entities/rotation.dart';

///Descriptes a abstract class for our Shapes.
abstract class Shape {
  int _currentShapeStateId;
  final List<List<Position>> _shapeStates;
  final Color _color;

  ///Our game object
  Shape(
      {required int shapeStateId,
      required Color color,
      required List<List<Position>> shapeStates})
      : _currentShapeStateId = shapeStateId,
        _color = color,
        _shapeStates = shapeStates;

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
    _currentShapeStateId = getNewShapeStateId(rotation);
  }

  List<Position> getCurrentShapeState() {
    return _shapeStates[_currentShapeStateId];
  }

  /// Gets the new State after rotating
  int getNewShapeStateId(Rotation rotation) {
    var newShapeStateId = _currentShapeStateId;
    if (rotation == Rotation.right) {
      if (_currentShapeStateId >= _shapeStates.length) {
        newShapeStateId = 0;
      } else {
        newShapeStateId++;
      }
    }
    if (rotation == Rotation.left) {
      if (_currentShapeStateId <= 0) {
        newShapeStateId = _shapeStates.length - 1;
      } else {
        newShapeStateId--;
      }
    }
    return newShapeStateId;
  }

  ///Gets Absolut Positions of the currend or rotated State
  List<Position> getAbsPositions(
      {required Position base, Rotation rotation = Rotation.none}) {
    final absPositions = <Position>[];
    for (var shapeState in _shapeStates) {
      absPositions.add(base + shapeState[getNewShapeStateId(rotation)]);
    }
    return absPositions;
  }
}
