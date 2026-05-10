class Airport {
  final String code;
  final String name;

  Airport({required this.code, required this.name});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}
