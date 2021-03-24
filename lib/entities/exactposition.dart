import 'dart:ffi';

import 'package:tetris/entities/position.dart';

class ExactPosition extends Position {
  ///Atributes
  final double _exactX;
  final double _exactY;

  ///Constructors
  ExactPosition(double exactX, double exactY)
      : _exactX = exactX,
        _x = Math.floor(exactX),
        _exactY = exactY,
        _y = Math.floor(exactY);

  ///Getters / Setters
  get exactX => _exactX;
  get exactY => _exactY;

  ///Operator
@override
  ExactPosition operator +(object o){
    if(object is Position){
      return ExactPosition(_exactX+);
    }
    if(object is ExactPosition){

    }
    return false;
  }
}
