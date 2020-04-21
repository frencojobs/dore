import 'package:dore/dore.dart';

Dore createApplication() {
  final port = 3000;
  final server = Dore(port);

  server.get('/', (req, res) {
    res.send('Hello, World');
  });

  return server;
}

void main() {
  final app = createApplication()..run();

  print('Server is listening on http://${app.host}:${app.port}');
}
