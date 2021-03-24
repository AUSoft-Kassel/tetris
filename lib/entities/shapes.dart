import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';

class ShapeO extends Shape {
  final Color _color = Color(0x919191FF);
  final List<List<Position>> _shapeStates = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(1, 0),
      Position(1,-1),
    ],
  ];
}

class ShapeI extends Shape {
  final Color _color = Color(0x3617FFFF);
  final List<List<Position>> _shapeStates = [
    [
      Position(0, 0),
      Position(0, 2),
      Position(0, 1),
      Position(0,-1),
    ],
    [
      Position( 0, 0),
      Position(-2, 0),
      Position(-1, 0),
      Position( 1, 0),
    ],
  ];
}

class ShapeL extends Shape {
  final Color _color = Color(0xFF5C5CFF);
  final List<List<Position>> _shapeStates = 
    [
      Position( 0, 0),
      Position( 0, 1),
      Position( 0, 2),
      Position( 1, 0),
    ],
        [
      Position( 0, 0),
      Position( 0,-1),
      Position( 1, 0),
      Position( 2, 0),
    ],
        [
      Position( 0, 0),
      Position( 0, 1),
      Position( 0, 2),
      Position(-1, 2),
    ],
    [
      Position( 0, 0),
      Position(-1, 0),
      Position( 1, 0),
      Position( 1, 1),
    ],
  ];
}

class ShapeJ extends Shape {
  final Color _color = Color(0xFFB536FF);
  final List<List<Position>> _shapeStates = [
    [
      Position( 0, 0),
      Position( 0, 1),
      Position( 0, 2),
      Position(-1, 0),
    ],
    [
      Position( 0, 0),
      Position(-1, 0),
      Position( 1, 0),
      Position(-1, 1),
    ],
    [
      Position( 0, 0),
      Position( 0, 1),
      Position( 0, 2),
      Position( 1, 2),
    ],
    [
      Position( 0, 0),
      Position( 0,-1),
      Position(-1, 0),
      Position(-2, 0),
    ],
  ];
}

class ShapeS extends Shape {
  final Color _color = Color(0xF830FFFF);
  final List<List<Position>> _shapeStates = [
    [
      Position( 0, 0),
      Position( 0, 1),
      Position( 1, 0),
      Position( 1,-1),
    ],
    [
      Position( 0, 0),
      Position( 1, 0),
      Position( 0,-1),
      Position(-1,-1),
    ],
  ];
}

class ShapeZ extends Shape {
  final Color _color = Color(0xD9FFBBFF);
  final List<List<Position>> _shapeStates = [
    [
      Position( 0, 0),
      Position( 0, 1),
      Position(-1, 0),
      Position(-1,-1),
    ],
    [
      Position( 0, 0),
      Position(-1, 0),
      Position( 0,-1),
      Position( 1,-1),
    ],
  ];
}

class ShapeT extends Shape {
  final Color _color = Color(0xFAFF75FF);
  final List<List<Position>> _shapeStates = [
    [
      Position( 0, 0),
      Position( 1, 0),
      Position( 1, 1),
      Position( 1,-1),
    ],
    [
      Position( 0, 0),
      Position(-1,-1),
      Position( 0,-1),
      Position( 1,-1),
    ],
    [
      Position( 0, 0),
      Position( 0,-1),
      Position( 0, 1),
      Position( 1, 0),
    ],
    [
      Position( 0, 0),
      Position(-1, 0),
      Position( 1, 0),
      Position( 0,-1),
    ],
  ];
}
