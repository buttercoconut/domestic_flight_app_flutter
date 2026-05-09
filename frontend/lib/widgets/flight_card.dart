import 'package:flutter/material.dart';
import 'package:domestic_flight_app_flutter/models/flight.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard({required this.flight, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.flight),
        title: Text('${flight.airline} - ${flight.flightNumber}'),
        subtitle: Text(
            '${flight.origin} → ${flight.destination}\n${flight.departureTime} – ${flight.arrivalTime}'),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to reservation screen
          },
          child: const Text('Book'),
        ),
      ),
    );
  }
}
