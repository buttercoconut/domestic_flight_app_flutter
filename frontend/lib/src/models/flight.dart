import 'package:json_annotation/json_annotation.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight {
  final String id;
  final String airline;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String imageUrl;

  Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.imageUrl,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);
  Map<String, dynamic> toJson() => _$FlightToJson(this);
}
