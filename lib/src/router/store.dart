part of dore_router;

/// Store
/// separated from the Router class
/// to reduce time complexity adding new handlers
class Store<T> {
  Map<String, Map<String, List<T>>> store = {
    'GET': {},
    'HEAD': {},
    'POST': {},
    'PUT': {},
    'DELETE': {},
    'CONNECT': {},
    'OPTIONS': {},
    'TRACE': {},
  };

  void add(String method, String url, List<T> fns) {
    if (!store[method].containsKey(url)) {
      store[method][url] = [];
    }
    store[method][url].addAll(fns);
  }

  List<T> find(String method, String url) {
    if (store[method].containsKey(url)) {
      return store[method][url];
    } else {
      return [];
    }
  }
}
