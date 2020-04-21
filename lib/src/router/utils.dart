part of dore_router;

String normalizeUrl(String input) {
  var output = input.trim();

  if (output.startsWith('/')) {
    output = output.substring(1);
  }

  if (output.endsWith('/')) {
    output = output.substring(0, output.length - 1);
  }

  return '/$output';
}
