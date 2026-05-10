class Flight {
  final String airline;
  final String flightNumber;
  final String departureTime;
  final String arrivalTime;
  final String duration;

  Flight(
      {required this.airline,
      required this.flightNumber,
      required this.departureTime,
      required this.arrivalTime,
      required this.duration});

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      airline: json['airline'] as String,
      flightNumber: json['flightNumber'] as String,
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      duration: json['duration'] as String,
    );
  }
}
