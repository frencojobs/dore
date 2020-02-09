Function(String) define_parser(String path) {
  List<String> path_segments = path.split('/');
  List<String> parameters = [];
  String regex_pattern = '';

  if (path_segments[0] == '') {
    path_segments.removeAt(0);
  }

  for (String segment in path_segments) {
    String head = segment[0];

    switch (head) {
      case '*':
        parameters.add('wildcard');
        regex_pattern += '/(.*)';
        break;
      case ':':
        parameters.add(segment.substring(1, segment.length));
        regex_pattern += '/([^/]+?)';
        break;
      default:
        regex_pattern += '/$segment';
        break;
    }
  }

  return (String url) {
    return extract_parameters(
      parameters,
      RegExp('^$regex_pattern\$').matchAsPrefix(url),
    );
  };
}

Map extract_parameters(List<String> parameters, Match match) {
  return {
    for (var i = 0; i < parameters.length; i++) parameters[i]: match.group(i + 1),
  };
}
