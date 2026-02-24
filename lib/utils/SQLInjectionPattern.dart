final sqlInjectionPattern = RegExp(
  r"""(?:\b(?:SELECT|INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE|EXEC|UNION|JOIN|INTO|FROM|WHERE|HAVING|GROUP\s+BY|ORDER\s+BY|SLEEP|BENCHMARK|WAITFOR|DELAY)\b)|(?:--)|(?:;)|(?:\/\*)|(?:\*\/)|(?:'[^\n]*?(?:OR|AND)[^\n]*?=)|(?:'.+?--)|(?:\b(?:OR|AND)\b.+?=)|(?:[^\w\s]?\bOR\b[^\w\s]?[^\w\s]?\d+[^\w\s]?=)|(?:'.+?')|(?:"[^"]*")|(?:\\x[0-9A-Fa-f]{2})|(?:0x[0-9A-Fa-f]+)""",
  caseSensitive: false,
);
bool isSafeInput(String input) {
  return !sqlInjectionPattern.hasMatch(input);
}