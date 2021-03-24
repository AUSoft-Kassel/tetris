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
  var grid = Grid();
  var actualSpeed = Constant.minSpeed;
  var lastTimeMoved;  // TODO: AH: Ich würde es noch länger machen a la activeShapeMovedLastWhen,
                      // aber das ist Geschmackssache.

  var activeShape;    // TODO: Generell sollte man die Attribute einer Klasse
                      // mit Typen versehen. Also Shape activeShape.

  var activeShapeAbsExactPosition = ExactPosition(Constant.numCols/2,Constant.numRows.toDouble());
                      // TODO: AH: Klingt eher wie die SpawnPosition (also wo starten neue 
                      // Shapes generell. Die könnte man final festlegen bei 
                      // der Initialisierung von Game. Wenn es aber um die 
                      // Position des activeShapes insgesamt geht, und das deutet 
                      // der Name ja an, dann würde ich den Wert eben nicht 
                      // initialisieren. Weil effektiv ist die ganze Einstellung 
                      // ja wirklich nur beim ersten Shape nach Neustart. Danach 
                      // werden ja wieder neue Shapes gespawnt ... und der 
                      // Wert activeShapeAbsExactPosition ist dann schon 
                      // verstellt noch durch den ehemaligen aktiven Shape.
                      // Kurzum: Einfach weglassen, ggf. eine spanLocation
                      // als Varoable lassen - die ist dan aber nur die spawnPosition.
                      // ExactPosition activeShapeAbsExactPosition = ExactPosition(Constant.numCols ~/ 2, numRows, numRows.toDouble());

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
  // void spawnShape() {
  //   activeShape = shapeShop.giveShape();
  //   activeShapePosition = Position(shapeSpawnAbsPosition.x,shapeSpawnAbsPosition.y);
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
  void moveShape(Direction direction,[Float distance]){
   distance ? distance = 1;
    var moveToExactPosition;
    if(direction == Direction.up   )
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition( distance,0);
    if(direction == Direction.down )
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition(-distance,0);
    if(direction == Direction.left )
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition(0,-distance);
    if(direction == Direction.right)
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition(0, distance);
    if(isPositionValid(activeShape,activeShapeAbsExactPosition,moveToExactPosition)){
      activeShapeAbsExactPosition+=moveToExactPosition;
    }
  }

  // TODO: AH: Umschreiben auf Position
  // Vom Ansatz aber richtig. Wir brauchen eine Methode, die den potenziellen 
  // zukünftigen State des Shapes prüft. Ich würde aber den Teil, der erstmal 
  // errechnet, wie die zukünftige Position (nach Drehung und Bewegung) aussieht,
  // extrahieren, denn wir brauchen den Teil nochmal, wenn wir die dann die 
  // tatsächliche Drehung durchführen. Außerdem würde ich ihn in Shape packen, 
  // denn da liegen alle Informationen direkt vor.
  // Und um null-Checks zu vermeiden, ist es eine Idee wert, in Direction und 
  // Rotation den Wert "none" einzufügen, um eine Nicht-Bewegung bzw. Nicht-
  // Rotation auszudrücken. Dann können wir uns hier die Fragezeichen sparen.
  // bool isShapePositionValid(Shape shape, Direction? direction, Rotation? rotation) {

  //   List<Position> futureAbsolutePositions = shape.positionsAfterMovementAndRotation(direction, rotation, activeShapeAbsExactPosition);
  //   for (var pos in futureAbsolutePositions) {
  //     if (pos2Shape[pos] != null && pos2Shape[pos] != shape) {   // ggf ist die Map in Grid
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  bool isPositionValid(Shape shape,ExactPosition exactAbsPosition, [Rotation rotateTo]{
    List<ExactPosition> absPositions;
    if(rotateTo != null){
      absPositions = shape.getRotatedState(exactAbsPosition, rotateTo);
    } else {
      absPositions = shape.getAbsPositions(exactAbsPosition);
    }
    List<ExactPosition> exactPositions = [];
    for (var absPosition in absPositions){
      exactAbsPosition.add(absPosition + exactAbsPosition);
    }
    List<ExactPosition> absExactPositions;
    for(Position cell in Grid){
      for(Position absPposition in) 
    }
  }

}
