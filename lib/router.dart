import 'package:dore/parser.dart';

class Router {
  List<Map> routes;

  Router() {
    this.routes = [];
  }

  void add(String method, String route, Function fn) {
    var parse = define_parser(route);

    this.routes.add({
      'method': method,
      'parse': parse,
      'handler': fn,
    });
  }

  Map find(String method, String url) {}
}
