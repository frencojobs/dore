part of dore_router;

/// Record
/// returns when the find of Router is called
class Record {
  final Map params;
  final List wares;
  final List handlers;

  Record({this.params, this.wares, this.handlers});
}
