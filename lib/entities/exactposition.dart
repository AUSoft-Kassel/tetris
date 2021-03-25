// TODO: AH: This import is unneeded
import 'dart:ffi';

import 'package:tetris/entities/position.dart';

class ExactPosition extends Position {
  ///Atributes
 final double _yExact;

  ///Constructors

  // TODO: Okay, der Fehler hier ist: ExactPosition ist eine Subklasse von Position.
  // Das heißt: Im Prinzip wird bei der Erstellung von ExactPosition quasi eine
  // Position mit erstellt, damit die Variablen und Methoden aus Position auch.
  // Wenn man das hier nicht explizit macht, dann wird automatisch quasi eine
  // Instanziierung von Position mitgemacht. Das geschieht, weil wir es nicht
  // explizit machen, dann aber ohne Argumente, denn welche soll der Compiler auch
  // nehmen?
  // super bezieht sich auf die Oberklasse Position.
  ExactPosition(int x, int y, double yExact) : _yExact = yExact, super(x,y);

  ///Getters / Setters
  get yEexact => _yExact;
}
