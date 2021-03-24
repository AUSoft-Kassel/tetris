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

  /// Descriptes the rotation of shapes.
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

  List<Position> getCurrentState(){
    return List<Position> _shapeStates[_currentShapeState];
  }
  List<Position> getRotatedState(Rotation rotateTo){
    return List<Position> _shapeStates[getNewShapeState(_shapeStates, _currentShapeState , rotateTo)];
  }
  
}
