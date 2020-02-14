import 'package:dore/dore.dart';

void main() {
  Router router = Router();

  router.get('/admin', () {
    print("called admin");
  });

  var obj = router.find(Method.GET, '/admin');

  print(obj['parameters']);
  obj['handlers'].forEach((fn) {
    fn();
  });
}
