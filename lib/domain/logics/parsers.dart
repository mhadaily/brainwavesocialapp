class Parsers {
  static getTextSpanTypes(Map<String, dynamic> data) {
    return data.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }
}
