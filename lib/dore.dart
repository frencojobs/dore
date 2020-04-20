library dore;

import 'dart:io';
import 'dart:convert';
import 'src/router.dart';

part 'src/request.dart';
part 'src/response.dart';

class Dore extends Router {
  int port;
  String address;
  Dore(this.port, {this.address});

  void run([Function callback]) async {
    final InternetAddress address =
        this.address ?? InternetAddress.loopbackIPv4;
    final port = this.port;

    var server = await HttpServer.bind(address, port);
    if (callback != null) callback();
    await for (HttpRequest req in server) {
      var _record = find(req.method, req.uri.toString());
      _record.handlers.forEach((fn) {
        fn(Request(req, _record.parameters), Response(req.response));
      });
      await req.response.close();
    }
  }
}
