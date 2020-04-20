part of dore;

class Request {
  final HttpRequest _req;
  final Map _parameters;
  Request(this._req, this._parameters);

  Map get params => _parameters;
}
