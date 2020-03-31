import 'package:dore/src/parser.dart';
import 'package:test/test.dart';

void main() {
  test('wildcard should match all paths:', () {
    var parse = define_parser('/*');
    expect(parse('/everything'), isMap);
    expect(parse('/everything'), {'wildcard': 'everything'});
  });
}
