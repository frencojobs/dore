import 'package:dore/dore.dart' show App;

void main() {
  var app = App();

  app.get('/user/:id', ({id}) {
    return "Hello, $id";
  });

  app.listen(3000);
}
