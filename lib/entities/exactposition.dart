// TODO: AH: This import is unneeded
import 'dart:ffi';

import 'package:tetris/entities/position.dart';

class ExactPosition extends Position {
  ///Atributes
 final double _yExact;

  ///Constructors

  ExactPosition(int x, int y, double yExact) : _yExact = yExact, super(x,y);
  ExactPosition.clone(Position o) : _yExact = o.y, super(x,y);

  ///Getters / Setters
  get yExact => _yExact;
}
