library dore;

import 'dart:io';
import 'dart:convert';
import 'src/router/router.dart';

part 'src/request.dart';
part 'src/response.dart';

class Dore extends Router {
  int port;
  String host;
  Dore(this.port, {this.host = 'localhost'});

  void run() async {
    final host = this.host;
    final port = this.port;

    var server = await HttpServer.bind(host, port);
    await for (HttpRequest req in server) {
      final requestStopWatch = Stopwatch()..start();

      final record = find(req.method, req.uri.toString());
      final request = Request(req, params: record.params);
      final response = Response(
        req.response,
        requestStopWatch: requestStopWatch,
      );

      if (record.handlers.isEmpty) response.code(404);

      for (Controller ware in record.wares) {
        await ware(request, response);
      }

      for (Controller handler in record.handlers) {
        handler(request, response);
      }

      await req.response.close();
    }
  }
}
