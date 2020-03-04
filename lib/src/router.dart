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
    this._routes = [];
    this.get = this._bind(Method.GET);
    this.head = this._bind(Method.HEAD);
    this.post = this._bind(Method.POST);
    this.put = this._bind(Method.PUT);
    this.delete = this._bind(Method.DELETE);
    this.connect = this._bind(Method.CONNECT);
    this.options = this._bind(Method.OPTIONS);
    this.trace = this._bind(Method.TRACE);
  }

  Function(String, dynamic) _bind(String method) {
    return (String route, dynamic fn_s) {
      if (fn_s is Function) {
        this.add(method, route, [fn_s]);
      } else if (fn_s is List<Function>) {
        this.add(method, route, fn_s);
      } else {}
    };
  }

  void add(String method, String route, List<Function> fns) {
    var parse = define_parser(route);

    this._routes.add(Route(method, parse, fns));
  }

  Map find(String method, String url) {
    Route r = this._routes.where((Route route) {
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
