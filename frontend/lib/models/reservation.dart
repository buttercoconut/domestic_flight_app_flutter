class Reservation {
  final String id;
  final String flightNumber;
  final String from;
  final String to;
  final String date;

  Reservation(
      {required this.id,
      required this.flightNumber,
      required this.from,
      required this.to,
      required this.date});
}
