import 'package:flutter/models/shapeform.dart';
import 'package:flutter/models/shapes.dart';

abstract class Shape{

final Position _anchorPosition

int _currentShapeState;
final List<Position> _shapeStates = [][]; // [0,0],[0,1],[1,0],[1,-1]

final Color _color;


void rotateRight(){
  if(_currentShapeState >= _relPosition[].count)
    _currentShapeState = 0;

  if(_currentShapeState < _relPosition[].count < _currentShapeState)
    _currentShapeState++;
}
void rotateLeft(){
  if(_currentShapeState <= 0)
    _currentShapeState = _relPositions.count;

  if(_currentShapeState > 0)
    _currentShapeState++;
}

}