class Flight {
  final String flightNumber;
  final String airline;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;

  Flight({
    required this.flightNumber,
    required this.airline,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['flightNumber'] as String,
      airline: json['airline'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
    );
  }
}
