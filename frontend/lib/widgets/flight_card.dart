import 'package:flutter/material.dart';
import '../models/flight.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text('${flight.flightNumber}'),
        subtitle: Text(
            '${flight.from} → ${flight.to} • ${flight.departureTime}'),
        trailing: TextButton(
          child: const Text('Book'),
          onPressed: () {
            // TODO: navigate to reservation flow
          },
        ),
      ),
    );
  }
}
