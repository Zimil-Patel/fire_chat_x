class CountryCode {
  final String code, name;

  CountryCode({
    required this.code,
    required this.name,
  });

  factory CountryCode.fromJson(Map map) => CountryCode(
        code: map['code'],
        name: map['name'],
      );
}
