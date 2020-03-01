import 'package:dore/dore.dart';

main() {
  Dore server = Dore(port: 3000);

  server.get('/user/:id', (ctx) {
    return "Hello, User ${ctx.params.id}";
  });

  server.listen();
}
