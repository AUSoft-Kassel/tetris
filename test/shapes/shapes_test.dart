import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeform.dart';
import 'package:tetris/entities/shapes.dart';

void main() {
  test('All Shapes can be constructed', () {
    var shapeI = Shape.fromForm(ShapeForm.i);
    var shapeL = Shape.fromForm(ShapeForm.l);
    var shapeJ = Shape.fromForm(ShapeForm.j);
    var shapeS = Shape.fromForm(ShapeForm.s);
    var shapeZ = Shape.fromForm(ShapeForm.z);
    var shapeO = Shape.fromForm(ShapeForm.o);
    var shapeT = Shape.fromForm(ShapeForm.t);
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
