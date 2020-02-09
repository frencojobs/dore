import 'package:dore/dore.dart';

void main() {
  var parse = define_parser('/foo/:bar');

  print(parse('/foo/what'));
}
