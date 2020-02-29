import 'parser.dart';

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
  List<Map> _routes;
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

  Function(String, dynamic) _bind(Method method) {
    return (String route, dynamic fn_s) {
      if (fn_s is Function) {
        this.add(method, route, [fn_s]);
      } else if (fn_s is List<Function>) {
        this.add(method, route, fn_s);
      } else {}
    };
  }

  void add(Method method, String route, List<Function> fns) {
    var parse = define_parser(route);

    this._routes.add({
      'method': method,
      'parse': parse,
      'handlers': fns,
    });
  }

  Map find(Method method, String url) {
    var r = this._routes.where((Map route) {
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
