part of dore;

class Response {
  HttpResponse res;
  Response(this.res);

  Response code(int statusCode) {
    res.statusCode = statusCode;
    return this;
  }

  int get statusCode => res.statusCode;

  Response header(String name, Object value) {
    res.headers.add(name, value);
    return this;
  }

  Response headers(Map<String, Object> headers) {
    headers.entries.forEach((entry) {
      header(entry.key, entry.value);
    });

    return this;
  }

  String getHeader(String key) {
    return res.headers.value(key);
  }

  void removeHeader(String key) {
    res.headers.removeAll(key);
  }

  bool hasHeader(String key) {
    return res.headers.value(key) != null;
  }

  Future redirect(String location, {int status = HttpStatus.movedTemporarily}) {
    return res.redirect(Uri.tryParse(location), status: status);
  }

  Response type(ContentType contentType) {
    header('Content-Type', contentType);
    return this;
  }

  Response send(dynamic body) {
    if (body is Map) {
      _json(body);
    } else if (body is String) {
      if (!hasHeader('Content-Type')) {
        type(ContentType.text);
      }

      _write(body);
      _close();
    }

    return this;
  }

  Future end() {
    return _close();
  }

  List<Cookie> get cookies => res.cookies;

  Future _close() {
    return res.close();
  }

  void _write(Object obj) {
    res.write(obj);
  }

  Response _json(Map<String, dynamic> data) {
    type(ContentType.json);

    send(json.encode(data));
    return this;
  }

  Response _html(String html) {
    type(ContentType.html);

    send(html);
    return this;
  }
}
