import 'package:flutter/foundation.dart';

/// Description of the class which define our position
class Position {
/*-----------------------------------------------------------------------------\
| Attributes                                                                   |
\-----------------------------------------------------------------------------*/
  final int _x;

  final int _y;

/*-----------------------------------------------------------------------------\
| Constructors                                                                 |
\-----------------------------------------------------------------------------*/
  /// Constructs Position object using rounded y coordinate
  Position(int x, int y)
      : _x = x,
        _y = y;

/*-----------------------------------------------------------------------------\
| Getters / Setters                                                            |
\-----------------------------------------------------------------------------*/
  /// Describes in which row position the position is located
  int get x => _x;

  /// Describes in which column position the position is located
  int get y => _y;


  @override
  bool operator ==(Object o) => o is Position && o.y == _y && o.x == _x;

  Position operator +(Position o) => Position(o.x + _x, o.y + _y);

  @override
  int get hashCode => _x * 1000 + _y;
}
