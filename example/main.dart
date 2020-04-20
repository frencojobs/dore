import 'package:dore/dore.dart';

Dore createApplication() {
  final port = 3000;
  final server = Dore(port);

  server.get('/user/:id', (Request req, Response res) {
    final id = req.params['id'];
    res.send('Hello, User $id');
  });

  return server;
}

void main() {
  createApplication().run();
}
