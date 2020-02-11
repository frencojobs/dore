import 'package:dore/parser.dart';

enum Method {
  GET,
  HEAD,
  POST,
  PUT,
  DELETE,
  CONNECT,
  OPTIONS,
  TRACE,
}

class Router {
  List<Map> routes;

  Router() {
    this.routes = [];
  }

  void add(Method method, String route, List<Function> fns) {
    var parse = define_parser(route);

    this.routes.add({
      'method': method,
      'parse': parse,
      'handlers': fns,
    });
  }

  Map find(Method method, String url) {
    var r = this.routes.where((Map route) {
      return route['method'] == method;
    }).lastWhere((Map route) {
      return route['parse'](url) != null;
    }, orElse: () {
      return null;
    });

    if (r == null) {
      return {
        'parameters': {},
        'handlers': [],
      };
    }

    return {
      'parameters': r['parse'](url),
      'handlers': r['handlers'],
    };
  }
}
