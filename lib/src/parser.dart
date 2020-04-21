Function(String) define_parser(String path) {
  var path_segments = path.split('/');
  var param_keys = <String>[];
  var regex_pattern = '';

  if (path_segments[0] == '') {
    path_segments.removeAt(0);
  }

  for (var segment in path_segments) {
    var head = segment.isEmpty ? '' : segment[0];

    switch (head) {
      case '*':
        param_keys.add('wildcard');
        regex_pattern += '/(.*)';
        break;
      case ':':
        param_keys.add(segment.substring(1, segment.length));
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
      return extract_params(
        param_keys,
        pattern.matchAsPrefix(url),
      );
    } else {
      return null;
    }
  };
}

Map extract_params(List<String> param_keys, Match match) {
  return {
    for (int i = 0; i < param_keys.length; i++)
      param_keys[i]: match.group(i + 1),
  };
}
