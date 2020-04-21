import 'package:dore/src/parser.dart';
import 'package:test/test.dart';

void main() {
  test('empty route shoud work:', () {
    var parse = define_parser('/');
    expect(parse('/'), isMap);
    expect(parse('/'), {});
  });
  test('wildcard should match all paths:', () {
    var parse = define_parser('/*');
    expect(parse('/everything'), isMap);
    expect(parse('/everything'), {'wildcard': 'everything'});
  });

  test('single parameter extraction:', () {
    var parse = define_parser('/:id');
    expect(parse('/1'), isMap);
    expect(parse('/1'), {'id': '1'});
  });

  test('single parameter (after path) extraction:', () {
    var parse = define_parser('/user/:id');
    expect(parse('/user/1'), isMap);
    expect(parse('/user/1'), {'id': '1'});
  });
}
