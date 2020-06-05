# Dore

A web framework for dart.

## Installation

The library will not be published until all the todos for the initial version is completed. Until then, cloning the repo is the only way available to test.

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

Or using `logger` middleware included out-of-the-box.

```dart
import 'package:dore/dore.dart';
import 'package:dore/middlewares/logger.dart';

Future<Dore> createApplication() async {
  final port = 3000;
  final server = Dore(port);

  server.use(await logger);

  server.get('/', (req, res) {
    res.send('Hello, World');
  });

  return server;
}

void main() async {
  final app = (await createApplication())..run();

  print('Server is listening on http://${app.host}:${app.port}');
}
```

Notice that all the middlewares has to be asynchronous.

## Todos

The initial version is likely to be published after these todos are finished.

- [ ] Support for `next` usage in middlewares, currently only `async` middlewares can be used
- [ ] Optimized for better performance, currently dore is relatively very slow compared to nodejs frameworks
- [ ] Support for view rendering, rendering is not possible right now

## Acknowledgment

This library was inspired by Polka, Fastify, and Express frameworks, and the API was based on those frameworks. This is one of my side-projects that I rarely do only when I don't have anything else to do, so the development can probably take forever.

## License

MIT &copy; Frenco Jobs
