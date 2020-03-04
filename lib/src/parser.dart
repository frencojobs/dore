Function(String) define_parser(String path) {
  List<String> path_segments = path.split('/');
  List<String> parameter_keys = [];
  String regex_pattern = '';

  if (path_segments[0] == '') {
    path_segments.removeAt(0);
  }

  for (String segment in path_segments) {
    String head = segment[0];

    switch (head) {
      case '*':
        parameter_keys.add('wildcard');
        regex_pattern += '/(.*)';
        break;
      case ':':
        parameter_keys.add(segment.substring(1, segment.length));
        regex_pattern += '/([^/]+?)';
        break;
      default:
        regex_pattern += '/$segment';
        break;
    }
  }

  return (String url) {
    RegExp pattern = RegExp('^$regex_pattern/?\$');
    if (pattern.hasMatch(url)) {
      return extract_parameters(
        parameter_keys,
        pattern.matchAsPrefix(url),
      );
    } else {
      return null;
    }
  };
}

Map extract_parameters(List<String> parameter_keys, Match match) {
  return {
    for (int i = 0; i < parameter_keys.length; i++) parameter_keys[i]: match.group(i + 1),
  };
}
