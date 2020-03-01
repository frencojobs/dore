import 'dart:io';

void createServer(Map options) async {
  int port = options['port'];
  final InternetAddress address = InternetAddress.loopbackIPv4;

  HttpServer requestServer = await HttpServer.bind(address, port);

  await for (HttpRequest req in requestServer) {
    req.response
      ..write("Hello, World!")
      ..close();
  }
}

void main() {
  createServer({'port': 3000});
}
