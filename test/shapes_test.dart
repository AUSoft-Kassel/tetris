import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/shape.dart';
import 'package:tetris/models/shape_i.dart';
import 'package:tetris/models/shape_l.dart';
import 'package:tetris/models/shape_j.dart';
import 'package:tetris/models/shape_s.dart';
import 'package:tetris/models/shape_z.dart';
import 'package:tetris/models/shape_o.dart';
import 'package:tetris/models/shape_t.dart';
import 'package:tetris/models/shapeform.dart';

void main() {
  test('All Shapes can be constructed', () {
    var shapeI = Shape.fromLetter(ShapeForm.i);
    var shapeL = Shape.fromLetter(ShapeForm.l);
    var shapeJ = Shape.fromLetter(ShapeForm.j);
    var shapeS = Shape.fromLetter(ShapeForm.s);
    var shapeZ = Shape.fromLetter(ShapeForm.z);
    var shapeO = Shape.fromLetter(ShapeForm.o);
    var shapeT = Shape.fromLetter(ShapeForm.t);
    expect(shapeI is ShapeI, true);
    expect(shapeL is ShapeL, true);
    expect(shapeJ is ShapeJ, true);
    expect(shapeS is ShapeS, true);
    expect(shapeZ is ShapeZ, true);
    expect(shapeO is ShapeO, true);
    expect(shapeT is ShapeT, true);
    expect(shapeI is Shape, true);
    expect(shapeL is Shape, true);
    expect(shapeJ is Shape, true);
    expect(shapeS is Shape, true);
    expect(shapeZ is Shape, true);
    expect(shapeO is Shape, true);
    expect(shapeT is Shape, true);
  });
}
