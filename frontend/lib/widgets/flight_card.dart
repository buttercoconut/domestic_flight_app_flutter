import 'package:flutter/material.dart';

class FlightCard extends StatelessWidget {
  final dynamic flight;

  const FlightCard({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${flight['flight_number']}'),
        subtitle: Text(
            '${flight['departure_airport']} → ${flight['arrival_airport']}\n${flight['departure_time']} - ${flight['arrival_time']}'),
        trailing: Text('${flight['price']}원'),
      ),
    );
  }
}
