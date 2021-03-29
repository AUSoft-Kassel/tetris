import 'package:tetris/entities/position.dart';

/// Position class with yExact
class ExactPosition extends Position {
  ///Atributes
  final double _yExact;

  ///Constructors

  ExactPosition(int x, int y, double yExact)
      : _yExact = ((yExact * 1000) % 1000) / 1000,
        super(x, y + (yExact * 1000) ~/ 1000);

  ///Returns ExactPosition Copy of Position
  ExactPosition.clone(Position position)
      : _yExact = position.y.toDouble(),
        super(position.x, position.y);

  ///Getters / Setters
  double get yExact => _yExact;

  Position get toPosition => Position(x, y);
}
