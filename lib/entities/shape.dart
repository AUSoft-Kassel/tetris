import 'package:flutter/material.dart';
import 'package:tetris/entities/direction.dart';
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

  /// Descriptes the rotation of shapes.
  // TODO: Ihr habt ja die shapeStates und dem currentShapeState sowieso
  // im Zugriff, weil es Klassenattribute sind. Also braucht ihr sie nicht 
  // als Argumente.
  void rotateShape(Rotation rotation) {
    if (rotation == Rotation.right) {
      _currentShapeState ++;
      if (_currentShapeState >= _shapeStates.length) {
        _currentShapeState = 0;
      }
    } else if (rotation == Rotation.left) {
      _currentShapeState --;
      if (_currentShapeState < 0) {
        _currentShapeState = _shapeStates.length - 1;
      }
    }
  }

  // TODO: AH: Geht auch ohne get. Wollte nur zeigen, dass man get auch 
  // für andere Werte als die Klassenvariablen nutzen kann.
  // List<Position> get relativePositions => _shapeStates[_currentShapeState];

  // List<Position> absolutePositionsAfterMovementAndRotation(Direction? direction, Rotation? rotation, Position absRefosition) {
  //   int newShapeState = _currentShapeState;
  //   if (rotation != null) {
  //   if (rotation == Rotation.right) {
  //     newShapeState ++;
  //     if (newShapeState >= _shapeStates.length) {
  //       newShapeState = 0;
  //     }
  //   } else{
  //     newShapeState --;
  //     if (newShapeState < 0) {
  //       newShapeState = _shapeStates.length - 1;
  //     }
  //   }
  //   List<Position> newRelativePositions = _shapeStates[newShapeState];
  //   if (direction != null) {
  //     for (var pos in newRelativePositions) {
  //       pos = pos + direction.toPosition();
  //     }
  //   }
  //   for (var pos in newRelativePositions) {
  //     pos = pos + absRefPosition;
  //   }
  // }
  // }




  void rotateShape(Rotation rotateTo) {
    _currentShapeState = newShapeState(_shapeStates, _currentShapeState , rotateTo);
  }

  int getNewShapeState(List<List<Position>> shapeStates ,int currentShapeState, Rotation rotateTo){    
    int newShapeState = currentShapeState;
    if (rotateTo = Rotation.right) {
        if (currentShapeState >= shapeStates.length) {
          newShapeState = 0;
        } else {
          newShapeState++;
        }
      }
    if (rotateTo = Rotation.left) {
        if (currentShapeState <= 0) {
          newShapeState = shapeStates.length;
        } else {
          newShapeState++;
        }
      }
      return newShapeState;
  }
  ///Get Absolut Positions of all Shapeparts
  // TODO: AH: Das ergibt nur eine relative Position
  List<Position> getAbsPositions(Position absPosition){
    return List<Position> _shapeStates[_currentShapeState];
  }
  List<Position> getRotatedAbsPositions(Rotation rotateTo){
    return List<Position> _shapeStates[getNewShapeState(_shapeStates, _currentShapeState , rotateTo)];
  }
  
}
