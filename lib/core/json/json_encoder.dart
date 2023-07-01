import 'dart:convert';

dynamic decodeJson(String input) {
  return json.decode(utf8.decode(input.codeUnits));
}
