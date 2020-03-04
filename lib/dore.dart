library Dore;

import 'dart:io';
import 'src/router.dart';

part 'src/request.dart';
part 'src/response.dart';

class Dore extends Router {
  int port;
  String address;
  Dore(this.port, {this.address});

  void listen([Function callback]) async {
    final InternetAddress address = this.address ?? InternetAddress.loopbackIPv4;
    final port = this.port;

    HttpServer server = await HttpServer.bind(address, port);
    callback();
    await for (HttpRequest req in server) {
      this.find(req.method, req.uri.toString())['handlers'].forEach((fn) {
        fn(Request(req), Response(req.response));
      });
      req.response.close();
    }
  }
}
