// TODO: AH: This import is unneeded
import 'dart:ffi';

import 'package:tetris/entities/position.dart';

class ExactPosition extends Position {
  ///Atributes
  final double _exactX; // TODO: AH: Das brauchen wir nicht... Wir haben ja x und y aus Position
  final double _exactY;

  ///Constructors
  ExactPosition(double exactX, double exactY)
      : _exactX = exactX,
        _x = Math.floor(exactX),
        _exactY = exactY,
        _y = Math.floor(exactY);
  // TODO: Okay, der Fehler hier ist: ExactPosition ist eine Subklasse von Position.
  // Das heißt: Im Prinzip wird bei der Erstellung von ExactPosition quasi eine
  // Position mit erstellt, damit die Variablen und Methoden aus Position auch.
  // Wenn man das hier nicht explizit macht, dann wird automatisch quasi eine
  // Instanziierung von Position mitgemacht. Das geschieht, weil wir es nicht
  // explizit machen, dann aber ohne Argumente, denn welche soll der Compiler auch
  // nehmen? Das richtige Vorgehen sieht eher so aus:
  // ExactPosition(int x, int y, double exactY) : _exactY = exactY, super(x,y);
  // super bezieht sich auf die Oberklasse Position.

  ///Getters / Setters
  get exactX => _exactX; // TODO: AH: Hint says it all!
  get exactY => _exactY;

  ///Operator
  @override
  
  ExactPosition operator +(object o){
    if(object is Position){
      return ExactPosition(_exactX+);
    }
    if(object is ExactPosition){

    }
    return false;
  }
  
  // TODO: Hier müssen wir uns überlegen, was eigentlich passieren soll. Wie 
  // besprochen dient die exakte Position eigentlich nur dazu, im richtigen 
  // Moment nach unten zu bewegen. Für die Darstellung brauchen wir nur Position.
  // Es wird nie gleichzeitig zwei Shapes geben, die eine ExactPosition haben, 
  // nur das sich bewegende. Das heißt: Wir brauchen eigentlich keine zwei
  // ExactPositions addieren. Was aber stimmt: Wenn wir von dem aktiven Shape
  // die Positionen seiner Blöcke herausfinden wollen, dann müssen wir jeweils 
  // Referenzposition + relative Blockposition rechnen. Und da ist die Idee 
  // recht cool, einfach den + Operator zu overriden .... Ich persönlich hab
  // da nur an eine Methode gedacht, die das für uns übernimmt, aber das hier 
  // ist besser. Richtig formuliert wäre der Operator dann aber so wie hier:

  // Position operator +(Position pos) => Position(x + pos.x, y + pos.y);

  // Lesehilfe: Wenn man eine ExactPosition (denn wir sind ja hier in der 
  // Klasse ExactPosition) + eine Position (siehe Argument) rechnet, dann 
  // ist das Ergebnis wiederum eine Position mit jeweils addierten Werten.
  // Allerdings kleiner Hinweis: Weil ExactPosition eine Unterklasse von 
  // Position ist, gilt: ExactPosition IST auch eine Position. Sie hat ein 
  // paar Zusatzeigenschaften, aber sie ist eine Position. Und wenn wir also 
  // in Position genau das obige definieren, dann brauchen wir es hier nicht 
  // nochmal, denn alles, was wir da schreiben, gilt hier auch - es sei denn 
  // wir überschreiben es hier. 
}
