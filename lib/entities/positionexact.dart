import 'dart:ffi';

import 'package:tetris/entities/position.dart';

class PositionExact {
  ///Atributes
  final Float _x;
  final Float _y;

  ///Constructors
  PositionExact(Float x, Float y)
      : _x = x,
        _y = y;

  ///Getters / Setters
  get x => _x;
  get y => _y;

  ///Operator
  @override
  bool operator ==(Object o) => o is Position && o.y == _y && o.x == _x;

  Position operator +(Position o) => Position(o.x + _x, o.y + _y);

  @override
  int get hashCode => _x * 1000 + _y;
}
