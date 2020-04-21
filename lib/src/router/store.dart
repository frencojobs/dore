part of dore_router;

/// Store
/// separated from the Router class
/// to reduce time complexity adding new handlers
class Store<T> {
  Map<String, Map<String, List<T>>> _store;

  Store() {
    _store = {
      'GET': {},
      'HEAD': {},
      'POST': {},
      'PUT': {},
      'DELETE': {},
      'CONNECT': {},
      'OPTIONS': {},
      'TRACE': {},
    };
  }

  void add(String method, String url, List<T> fns) {
    if (!_store[method].containsKey(url)) {
      _store[method][url] = [];
    }
    _store[method][url].addAll(fns);
  }

  List<T> find(String method, String url) {
    if (_store[method].containsKey(url)) {
      return _store[method][url];
    } else {
      return [];
    }
  }
}
