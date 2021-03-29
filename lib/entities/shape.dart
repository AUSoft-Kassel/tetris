import 'package:flutter/material.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shapeform.dart';
import 'package:tetris/entities/shapes.dart';
import 'package:tetris/entities/rotation.dart';

///Descriptes a abstract class for our Shapes.
abstract class Shape {
  int _currentShapeStateId;
  final List<List<Position>> _relRotatingPositions;
  final Color _color;

  ///getter
  Color get color => _color;

  ///Our game object
  Shape({required int shapeStateId, required Color color, required List<List<Position>> relRotatingPositions})
      : _currentShapeStateId = shapeStateId,
        _color = color,
        _relRotatingPositions = relRotatingPositions;

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
    _currentShapeStateId = newShapeStateId(rotation);
  }

  ///
  List<Position> currentShapeState() => _relRotatingPositions[_currentShapeStateId];

  /// Gets the new State after rotating
  int newShapeStateId(Rotation? rotation) {
    var newShapeStateId = _currentShapeStateId;
    if (rotation == Rotation.right) {
      if (_currentShapeStateId >= _relRotatingPositions.length) {
        newShapeStateId = 0;
      } else {
        newShapeStateId++;
      }
    }
    if (rotation == Rotation.left) {
      if (_currentShapeStateId <= 0) {
        newShapeStateId = _relRotatingPositions.length - 1;
      } else {
        newShapeStateId--;
      }
    }

    return newShapeStateId;
  }

  ///Gets Absolut Positions of the currend or rotated or moved State
  List<Position> absPositions({required Position base, Rotation? rotation, Direction? direction}) {
    final relPositions = _relRotatingPositions[newShapeStateId(rotation)];
    final absPositions = <Position>[];
    for (var relPosition in relPositions) {
      absPositions.add(base + relPosition + (direction?.toPosition ?? Position(0, 0)));
    }
    return absPositions;
  }
}
