import 'package:dore/dore.dart';

main() {
  Dore server = Dore(port: 3000);

  server.get('/user/:id', () {
    return "Hello, User";
  });

  server.listen();
}
