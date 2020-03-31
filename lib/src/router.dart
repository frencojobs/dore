import 'parser.dart';

abstract class Method {
  static String GET = 'GET';
  static String HEAD = 'HEAD';
  static String POST = 'POST';
  static String PUT = 'PUT';
  static String DELETE = 'DELETE';
  static String CONNECT = 'CONNECT';
  static String OPTIONS = 'OPTIONS';
  static String TRACE = 'TRACE';
}

class Route {
  String method;
  Function(String) parse;
  List<Function> handlers;

  Route(this.method, this.parse, this.handlers);
}

class Router {
  List<Route> _routes;
  Function(String, dynamic) get, head, post, put, delete, connect, options, trace;

  Router() {
    _routes = [];
    get = _bind(Method.GET);
    head = _bind(Method.HEAD);
    post = _bind(Method.POST);
    put = _bind(Method.PUT);
    delete = _bind(Method.DELETE);
    connect = _bind(Method.CONNECT);
    options = _bind(Method.OPTIONS);
    trace = _bind(Method.TRACE);
  }

  Function(String, dynamic) _bind(String method) {
    return (String route, dynamic fn_s) {
      if (fn_s is Function) {
        add(method, route, [fn_s]);
      } else if (fn_s is List<Function>) {
        add(method, route, fn_s);
      } else {}
    };
  }

  void add(String method, String route, List<Function> fns) {
    var parse = define_parser(route);

    _routes.add(Route(method, parse, fns));
  }

  Map find(String method, String url) {
    var r = _routes.where((Route route) {
      return route.method == method;
    }).lastWhere((Route route) {
      return route.parse(url) != null;
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
      'parameters': r.parse(url),
      'handlers': r.handlers,
    };
  }
}
