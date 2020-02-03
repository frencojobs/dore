import 'dart:io';

void main() async {
  const port = 8080;
  final address = InternetAddress.loopbackIPv4;

  var requestServer = await HttpServer.bind(address, port);
  print('listening on localhost: ${requestServer.port}');

  await for (HttpRequest request in requestServer) {
    request.response
      ..write('Hello, World')
      ..close();
  }
}
