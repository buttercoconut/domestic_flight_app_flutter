import 'package:flutter/material.dart';
import '../models/flight.dart';

class ReservationScreen extends StatelessWidget {
  final Flight flight;
  const ReservationScreen({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reserve ${flight.flightNumber}')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: call reservation API
          },
          child: const Text('Reserve Now'),
        ),
      ),
    );
  }
}
