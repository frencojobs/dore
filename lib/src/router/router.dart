library dore_router;

import 'package:dore/dore.dart';
import 'package:dore/src/parser.dart';

part 'methods.dart';
part 'record.dart';
part 'route.dart';
part 'store.dart';
part 'utils.dart';

typedef Controller = Function(Request, Response);
typedef Definition = Function(String, Controller);

/// Router
/// not only with dore, can also works standalone
class Router {
  List<Route> _routes;
  List<Controller> _wares;
  Store<Controller> _handlers;
  Definition get, head, post, put, delete, connect, options, trace;

  Router() {
    _routes = [];
    _wares = [];
    _handlers = Store();

    get = _bind(Method.GET);
    head = _bind(Method.HEAD);
    post = _bind(Method.POST);
    put = _bind(Method.PUT);
    delete = _bind(Method.DELETE);
    connect = _bind(Method.CONNECT);
    options = _bind(Method.OPTIONS);
    trace = _bind(Method.TRACE);
  }

  Function(String, Function) _bind(String method) {
    return (String route, Function fn) {
      _add(method, route, [fn]);
    };
  }

  void _add(String method, String route, List<Controller> fns) {
    final url = normalizeUrl(route);
    final parse = define_parser(url);

    _routes.add(Route(url, method, parse));
    _handlers.add(method, url, fns);
  }

  Record find(String method, String url) {
    final r = _routes.where((Route route) {
      return route.method == method;
    }).lastWhere((Route route) {
      return route.parse(url) != null;
    }, orElse: () {
      return null;
    });

    if (r == null) {
      return Record(
        params: {},
        wares: _wares,
        handlers: [],
      );
    }

    return Record(
      params: r.parse(url),
      wares: _wares,
      handlers: _handlers.find(method, r.url),
    );
  }

  Router use(Controller fn) {
    _wares.add(fn);
    return this;
  }
}
