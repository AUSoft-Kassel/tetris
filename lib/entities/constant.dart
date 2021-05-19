import 'package:tetris/entities/position.dart';

/// Class which holds static data - more or less global variables
abstract class Constant {
  /// Minimum gamespeed
  //static const minSpeed = 0.0; //test speed

  static const minSpeed = 1.0;

  /// Maximum gamespeed
  static const maxSpeed = 5.0;

  /// Speed Increse per Level
  static const speedPerLevel =
      (Constant.maxSpeed - Constant.minSpeed) / Constant.maxLevel;

  /// Maximum level
  static const maxLevel = 50;

  /// After how many Shapes landed the level increase by 1
  static const shapesPerLevel = 5;

  /// The number of rows of a standard Tetris field
  static const numRows = 20;

  /// The number of columns of a standard Tetris field
  static const numCols = 10;

  /// Starting point of a shape in the Grid
  static const Position spawnPosition =
      Position(Constant.numCols ~/ 2, Constant.numRows - 1);
}
