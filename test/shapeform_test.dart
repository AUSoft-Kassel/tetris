import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/models/shapeform.dart';

void main() {
  test('ShapeFormEnum works', () {
    var i = 0;
    var l = 0;
    var j = 0;
    var t = 0;
    var o = 0;
    var s = 0;
    var z = 0;
    var other = 0;
    for (var form in ShapeForm.values) {
      if (form == ShapeForm.i) {
        i++;
      } else if (form == ShapeForm.j) {
        j++;
      } else if (form == ShapeForm.l) {
        l++;
      } else if (form == ShapeForm.o) {
        o++;
      } else if (form == ShapeForm.s) {
        s++;
      } else if (form == ShapeForm.t) {
        t++;
      } else if (form == ShapeForm.z) {
        z++;
      } else {
        other++;
      }
    }
    expect(i, 1);
    expect(l, 1);
    expect(j, 1);
    expect(t, 1);
    expect(o, 1);
    expect(s, 1);
    expect(z, 1);
    expect(other, 0);
  });
}
