import 'package:models/shapeform.dart';
import 'package:models/shapes.dart';

abstract class Shape{

final Position _anchorPosition

int _currentShapeState;
final List<List<Position>> _shapeStates;= [[]];
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