import 'dart:ffi';

import 'package:tetris/entities/position.dart';

class ExactPosition {
  ///Atributes
  final double _x;
  final double _y;

  ///Constructors
  ExactPosition(double x, double y)
      : _x = x,
        _y = y;

  ///Getters / Setters
  get x => _x;
  get y => _y;

  ///Operator

  ExactPosition operator +(ExactPosition o) =>
      ExactPosition(o.x + _x, o.y + _y);
}
