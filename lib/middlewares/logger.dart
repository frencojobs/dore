import 'package:dore/dore.dart';

class TerminalText {
  static String bold(dynamic v) {
    return '\x1b[1m$v\x1b[0m';
  }
}

// all middlewares are async because I do not know how
// to implement the `next` callback logic and also
// I think async is actually better sometimes
Future<void> logger(Request req, Response res) async {
  final method = req.method;
  final query = req.query;
  final statusCode = TerminalText.bold(res.statusCode);

  final responseTime = res.getResponseTime;

  final msg = '$method $query $statusCode ${responseTime}ms';
  print(msg);
}
