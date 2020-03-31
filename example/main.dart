import 'package:dore/dore.dart';

void main() {
  var server = Dore(3000);

  server.get('/user/:id', (Request req, Response res) {
    res.send('Hello, User');
  });

  server.listen(() {
    print('Server is listening on port 3000.');
  });
}