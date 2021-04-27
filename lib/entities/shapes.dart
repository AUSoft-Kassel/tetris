import 'dart:math';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';

/// Description of the class which will show us the Shape O.
class ShapeO extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(1, 0),
      const Position(1, 1),
    ],
  ];

  ///Constructor
  ShapeO()
      : super(
          color: 0xFF919191,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape I.
class ShapeI extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(0, 2),
      const Position(0, 1),
      const Position(0, -1),
    ],
    [
      const Position(0, 0),
      const Position(-2, 0),
      const Position(-1, 0),
      const Position(1, 0),
    ],
  ];

  ///Constructor
  ShapeI()
      : super(
          color: 0xFF3617FF,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape L.
class ShapeL extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(0, 2),
      const Position(1, 0),
    ],
    [
      const Position(0, 0),
      const Position(0, -1),
      const Position(1, 0),
      const Position(2, 0),
    ],
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(0, 2),
      const Position(-1, 2),
    ],
    [
      const Position(0, 0),
      const Position(-1, 0),
      const Position(1, 0),
      const Position(1, 1),
    ],
  ];

  ///Constructor
  ShapeL()
      : super(
          color: 0xFFFF5C5C,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape  J.
class ShapeJ extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(0, 2),
      const Position(-1, 0),
    ],
    [
      const Position(0, 0),
      const Position(-1, 0),
      const Position(1, 0),
      const Position(-1, 1),
    ],
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(0, 2),
      const Position(1, 2),
    ],
    [
      const Position(0, 0),
      const Position(0, -1),
      const Position(-1, 0),
      const Position(-2, 0),
    ],
  ];

  ///Constructor
  ShapeJ()
      : super(
          color: 0xFFFFB536,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape S.
class ShapeS extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(1, 0),
      const Position(1, -1),
    ],
    [
      const Position(0, 0),
      const Position(1, 0),
      const Position(0, -1),
      const Position(-1, -1),
    ],
  ];

  ///Constructor
  ShapeS()
      : super(
          color: 0xFFF830FF,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape Z.
class ShapeZ extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(0, 1),
      const Position(-1, 0),
      const Position(-1, -1),
    ],
    [
      const Position(0, 0),
      const Position(-1, 0),
      const Position(0, -1),
      const Position(1, -1),
    ],
  ];

  ///Constructor
  ShapeZ()
      : super(
          color: 0xFFD9FFBB,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}

/// Description of the class which will show us the Shape T.
class ShapeT extends Shape {
  static final List<List<Position>> _relRotatingPositions = [
    [
      const Position(0, 0),
      const Position(1, 0),
      const Position(1, 1),
      const Position(1, -1),
    ],
    [
      const Position(0, 0),
      const Position(-1, -1),
      const Position(0, -1),
      const Position(1, -1),
    ],
    [
      const Position(0, 0),
      const Position(0, -1),
      const Position(0, 1),
      const Position(1, 0),
    ],
    [
      const Position(0, 0),
      const Position(-1, 0),
      const Position(1, 0),
      const Position(0, -1),
    ],
  ];

  ///Constructor
  ShapeT()
      : super(
          color: 0xFFFAFF75,
          relRotatingPositions: _relRotatingPositions,
          rotation: Random().nextInt(_relRotatingPositions.length),
        );
}
