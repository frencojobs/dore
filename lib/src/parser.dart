Function(String) define_parser(String path) {
  var path_segments = path.split('/');
  var parameter_keys = <String>[];
  var regex_pattern = '';

  if (path_segments[0] == '') {
    path_segments.removeAt(0);
  }

  for (var segment in path_segments) {
    var head = segment[0];

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
    var pattern = RegExp('^$regex_pattern/?\$');
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
