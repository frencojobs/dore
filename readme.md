![dore logo](media/dore.png)

# Dore

A web framework for dart.

## Usage

After installation is completed, a simple server can be created like the code described.

```dart
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
  final app = createApplication();

  app.run((){
      print('Server is listening on http://${app.host}:${app.port}');
  });
}

```
## License

MIT &copy; Frenco Jobs
