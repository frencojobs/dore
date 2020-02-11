import 'package:dore/dore.dart';

void main() {
  Router router = Router();

  router.add(
    Method.GET,
    '/user/:id',
    [
      () {
        print("get user");
      }
    ],
  );

  var obj = router.find(Method.GET, '/user/123');

  print(obj['parameters']);
  obj['handlers'].forEach((fn) {
    fn();
  });
}
