import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shapeform.dart';
import 'package:tetris/entities/shapes.dart';
import 'package:tetris/entities/rotation.dart';

///Descriptes a abstract class for our Shapes.
abstract class Shape {
  int _rotation;
  final List<List<Position>> _relRotatingPositions;
  final int _color;

  ///getter
  int get color => _color;

  /*--------------------------------------------------------------------------*/
  /* Constructor                                                              */
  /*--------------------------------------------------------------------------*/
  /// Standard constructor
  Shape({
    required int rotation,
    required int color,
    required List<List<Position>> relRotatingPositions,
  })   : _rotation = rotation,
        _color = color,
        _relRotatingPositions = relRotatingPositions;

  /// Factory constructor. Returns the corresponding subclass object, depending
  /// on the value of paramter [form].
  factory Shape.fromForm(ShapeForm form) {
    if (form == ShapeForm.i) return ShapeI();
    if (form == ShapeForm.j) return ShapeJ();
    if (form == ShapeForm.l) return ShapeL();
    if (form == ShapeForm.z) return ShapeZ();
    if (form == ShapeForm.s) return ShapeS();
    if (form == ShapeForm.t) return ShapeT();
    return ShapeO();
  }

  /// Rotate a shape.
  void rotateShape(Rotation rotation) {
    _rotation = _nextRotationState(rotation);
  }

  /// currentRelativePositions
  List<Position> currentRelativePositions() => _relRotatingPositions[_rotation];

  /// Gets the new State after rotating
  int _nextRotationState(Rotation? rotation) {
    if (rotation != Rotation.right && rotation != Rotation.left) return _rotation;
    var newShapeStateId = _rotation + (rotation == Rotation.right ? 1 : -1);
    if (newShapeStateId >= _relRotatingPositions.length) {
      newShapeStateId = 0;
    } else if (newShapeStateId < 0) {
      newShapeStateId = _relRotatingPositions.length - 1;
    }
    return newShapeStateId;
  }

  ///Gets absolut Positions of the current or rotated or moved State
  List<Position> absolutePositions({required Position base, Rotation? rotation, Direction? direction}) {
    final relPositions = _relRotatingPositions[_nextRotationState(rotation)];
    final absPositions = <Position>[];
    for (var relPosition in relPositions) {
      absPositions.add(
          base + relPosition + (direction?.toPosition ?? const Position(0, 0)));
    }
    return absPositions;
  }
}
