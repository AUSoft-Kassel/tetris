import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/exactposition.dart';
import 'package:tetris/entities/grid.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';
import 'package:tetris/entities/direction.dart';

// TODO: AH: Wir sollten versuchen, die Klasse immutable anzulegen, also
// sind per Definitionem alle Felder final. Wo es nicht klappt, helfe ich 
// dann.
class Game {
  var shapeShop = ShapeShop();  // TODO: AH: Ich würde bevorzugen: Private mit Getter
  
  // TODO: AH: Keine Ahnung, was Grid sein soll. Wenn es sich aber um das
  // Spielfeld im grafischen Sinne handelt, dann verstößt es gegen das D in SOLID:
  // Dependency Inversion. Alle unsere Dateien in Entities WERDEN NIE eine 
  // Datei außerhalb von Entities importieren. Es geht nur in umgekehrter 
  // Richtung. Eine GUI beobachtet das Spielfeld. Sie wird nie vom Spielfeld
  // angesteuert. Sollte es sich um Grid in einem anderen Sinne handeln, also 
  // die Verwaltung des Spielfeldes, dann finde ich, dass alles dafür schon 
  // in DIESER Klasse ist. Wir wissen die Dimensionen des Grids und wir wissen 
  // durch die Maps, welche Positionen durch Shapes belegt sind.
  // Sollte das Grid die Positionen enthalten, dann ist das okay.
  List<Shape> grid = [];
  var actualSpeed = Constant.minSpeed;
  var lastTimeActiveShapeMoved;

  Shape _activeShape;
  List<ExactPosition> activeShapeAbsPositions;
  Position _activeShapePosition;
  final Position _spawnPosition = Position((Constant.numCols/2).floor,Constant.numRows);

  Game() {
    spawnShape();
  }

  // TODO: AH: Generell müssen wir ihmn sagen, welches Shape er spawnen soll.
  // Sinn würde für mich machen:
  // void spawnShape() {
  //   final shape = shapeShop.giveShape();
  //   grid.registerShapeAt(shape, spawnPosition);
  // } // TODO: AH: Das setzt voraus, dass Grid bekannt ist (also bspw. hier 
  // erzeugt und in einem Attribut gespeichert).


  // TODO: AH: Oops, das war ja schon da .....
  void spawnShape() {
    _activeShape = shapeShop.giveShape();
    _activeShapePosition = Position(_spawnPosition.x,_spawnPosition.y);
  // }  // TODO: AH: Außerdem wird bei dem aktiven Shape ja die ExactPositon
        // gespeichert. Folglich müssen wir keine Umrechnung auf Position vornehmen
        //   activeShapePosition = ExactPosition.clone(spawnPosition)
        // Der Konstruktor .clone müsste in ExactPosition definiert sein und 
        // er kopiert einfach die werte aus einer mitgegebenen ExactPosition.
        // Warum nicht einfach activeShapePosition = spawnPosition?
        // Weil das bedeuten würde, dass einfach eine Referenz auf die 
        // spawnPosition übergeben würde. Änderungen an activeShapePosition
        // würden spawnPosition verändern! Bei uns wäre die Auswirkung allerdings 
        // wohl relativ neu, weil wir nie etwas ändern, sondern nur neue 
        // Objekte erstellen (immutable state).


  // TODO: AH: Muss umgeschrieben werden auf neue Definition von exactPosition
  void moveShape([ Direction direction],[ num distance])
  {
     final distance ? distance = 1.0;
     final direction ? direction = Direction.down;

    var moveToPosition;

    if(direction == Direction.down ){
      if(distance is int) moveToPosition = _activeShapePosition.y + distance;
      if(distance is double || distance is Float) moveToPosition = _activeShapePosition.y + distance;
    }
    if(direction == Direction.left ){
       if(distance is int) moveToPosition = _activeShapePosition.x - distance;
      if(distance is double || distance is Float) moveToPosition = _activeShapePosition.x - distance;
    }
    if(direction == Direction.right){
       if(distance is int) moveToPosition = _activeShapePosition.x + distance;
      if(distance is double || distance is Float) moveToPosition = _activeShapePosition.x + distance;
    }

    if(isPositionValid(moveToPosition)){
      activeShapeAbsPositions = _activeShape.getAbsPositions(base:moveToPosition);
      _activeShapePosition = moveToPosition;
    };
  }

  bool isPositionValid(Shape shape, Position moveToPosition, [Rotation rotation = Rotation.none]){
    bool isValid = false;
  
    List<Position> absPositions = shape.getAbsPositions(moveToPosition, rotation);

    for(var absPosition in absPositions){
      if(grid[absPosition] is Shape && grid[absPosition] != _activeShape)
        isValid = true;
    }
    return isValid;
  }
}
}