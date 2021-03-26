import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';

/// Description of the class which will show us the Shape O.
class ShapeO extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(1, 0),
      Position(1, -1),
    ],
  ];

  ///Constructor
  ShapeO()
      : super(
          color: const Color(0x919191FF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape I.
class ShapeI extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(0, 2),
      Position(0, 1),
      Position(0, -1),
    ],
    [
      Position(0, 0),
      Position(-2, 0),
      Position(-1, 0),
      Position(1, 0),
    ],
  ];

  ///Constructor
  ShapeI()
      : super(
          color: const Color(0x3617FFFF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape L.
class ShapeL extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(0, 2),
      Position(1, 0),
    ],
    [
      Position(0, 0),
      Position(0, -1),
      Position(1, 0),
      Position(2, 0),
    ],
    [
      Position(0, 0),
      Position(0, 1),
      Position(0, 2),
      Position(-1, 2),
    ],
    [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(1, 1),
    ],
  ];

  ///Constructor
  ShapeL()
      : super(
          color: const Color(0xFF5C5CFF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape  J.
class ShapeJ extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(0, 2),
      Position(-1, 0),
    ],
    [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(-1, 1),
    ],
    [
      Position(0, 0),
      Position(0, 1),
      Position(0, 2),
      Position(1, 2),
    ],
    [
      Position(0, 0),
      Position(0, -1),
      Position(-1, 0),
      Position(-2, 0),
    ],
  ];

  ///Constructor
  ShapeJ()
      : super(
          color: const Color(0xFFB536FF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape S.
class ShapeS extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(1, 0),
      Position(1, -1),
    ],
    [
      Position(0, 0),
      Position(1, 0),
      Position(0, -1),
      Position(-1, -1),
    ],
  ];

  ///Constructor
  ShapeS()
      : super(
          color: const Color(0xF830FFFF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape Z.
class ShapeZ extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(-1, 0),
      Position(-1, -1),
    ],
    [
      Position(0, 0),
      Position(-1, 0),
      Position(0, -1),
      Position(1, -1),
    ],
  ];

  ///Constructor
  ShapeZ()
      : super(
          color: const Color(0xD9FFBBFF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape T.
class ShapeT extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      Position(0, 0),
      Position(1, 0),
      Position(1, 1),
      Position(1, -1),
    ],
    [
      Position(0, 0),
      Position(-1, -1),
      Position(0, -1),
      Position(1, -1),
    ],
    [
      Position(0, 0),
      Position(0, -1),
      Position(0, 1),
      Position(1, 0),
    ],
    [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(0, -1),
    ],
  ];

  ///Constructor
  ShapeT()
      : super(
          color: const Color(0xFAFF75FF),
          relRotatingPositions: _relRotatingPositions,
          shapeStateId: Random().nextInt(_relRotatingPositions.length),
        );
}
