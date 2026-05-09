class Reservation {
  final String reservationId;
  final String flightNumber;
  final String passengerName;
  final int seatNumber;

  Reservation({
    required this.reservationId,
    required this.flightNumber,
    required this.passengerName,
    required this.seatNumber,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservationId'] as String,
      flightNumber: json['flightNumber'] as String,
      passengerName: json['passengerName'] as String,
      seatNumber: json['seatNumber'] as int,
    );
  }
}
