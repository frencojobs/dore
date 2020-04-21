part of dore;

/// query - Uri
/// raw - HttpRequest
/// params - extracted parameters
/// headers - headers
/// ip - IP Address
/// hostname - host:port
class Request {
  final HttpRequest _req;
  final Map _parameters;
  Map<String, dynamic> _body;
  Request(this._req, {params}) : _parameters = params;

  set body(Map<String, dynamic> newBody) => _body = newBody;
  String get method => _req.method;
  String get query => _req.uri.toString();
  Map<String, dynamic> get body => _body;
  HttpRequest get raw => _req;
  Map get params => _parameters;
  HttpHeaders get headers => _req.headers;
  String get ip => _req.connectionInfo.remoteAddress.address;
  String get hostname =>
      '${_req.headers.host}:${_req.connectionInfo.localPort}';
}
