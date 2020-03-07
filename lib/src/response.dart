part of Dore;

class Response {
  HttpResponse res;
  Response(this.res);

  Response code(int statusCode) {
    this.res.statusCode = statusCode;
    return this;
  }

  int get statusCode => this.res.statusCode;

  Response header(String name, Object value) {
    this.res.headers.add(name, value);
    return this;
  }

  Response headers(Map<String, Object> headers) {
    headers.entries.forEach((entry) {
      this.header(entry.key, entry.value);
    });

    return this;
  }

  String getHeader(String key) {
    return this.res.headers.value(key);
  }

  void removeHeader(String key) {
    this.res.headers.removeAll(key);
  }

  bool hasHeader(String key) {
    return this.res.headers.value(key) != null;
  }

  Future redirect(String location, {int status = HttpStatus.movedTemporarily}) {
    return this.res.redirect(Uri.tryParse(location), status: status);
  }

  Response type(ContentType contentType) {
    this.header('Content-Type', contentType);
    return this;
  }

  Response send(dynamic body) {
    if (body is Map) {
      this._json(body);
    } else if (body is String) {
      if (!this.hasHeader('Content-Type')) {
        this.type(ContentType.text);
      }

      this._write(body);
      this._close();
    }

    return this;
  }

  Future end() {
    return this._close();
  }

  List<Cookie> get cookies => this.res.cookies;

  Future _close() {
    return this.res.close();
  }

  void _write(Object obj) {
    this.res.write(obj);
  }

  Response _json(Map<String, dynamic> data) {
    this.type(ContentType.json);

    this.send(json.encode(data));
    return this;
  }

  Response _html(String html) {
    this.type(ContentType.html);

    this.send(html);
    return this;
  }
}
