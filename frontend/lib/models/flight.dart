class Flight {
  final String flightNumber;
  final String from;
  final String to;
  final String departureTime;

  Flight(
      {required this.flightNumber,
      required this.from,
      required this.to,
      required this.departureTime});

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['flightNumber'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      departureTime: json['departureTime'] as String,
    );
  }
}
