part of dore_router;

/// Route
/// stores a url - act as a key to connect with handlers store
/// http method - act as a filter
/// and parse - to parse the request uri
class Route {
  String url;
  String method;
  Function(String) parse;

  Route(this.url, this.method, this.parse);
}
