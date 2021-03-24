class ExactPosition {
  ///Atributes
  final double _exactX;
  final double _exactY;

  ///Constructors
  ExactPosition(double exactX, double exactY)
      : _exactX = exactX,
        _exactY = exactY;

  ///Getters / Setters
  get exactX => _exactX;
  get exactY => _exactY;

  ///Operator
  ExactPosition operator +(ExactPosition o) =>
      ExactPosition(o.exactX + _exactX, o.exactY + exactY);
}
