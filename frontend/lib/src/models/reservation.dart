import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  final String id;
  final String flightId;
  final String passengerName;
  final String seatNumber;
  final DateTime reservationDate;

  Reservation({
    required this.id,
    required this.flightId,
    required this.passengerName,
    required this.seatNumber,
    required this.reservationDate,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
