part of dore;

/// raw - HttpRequest
/// params - extracted parameters
/// headers - headers
/// ip - IP Address
/// hostname - host:port
class Request {
  final HttpRequest _req;
  final Map _parameters;
  Request(this._req, this._parameters);

  HttpRequest get raw => _req;

  Map get params => _parameters;

  HttpHeaders get headers => _req.headers;

  String get ip => _req.connectionInfo.remoteAddress.address;

  String get hostname =>
      '${_req.headers.host}:${_req.connectionInfo.localPort}';
}
