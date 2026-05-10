import 'package:flutter/material.dart';
import '../models/flight.dart';

class ReservationScreen extends StatelessWidget {
  final Flight? flight;

  const ReservationScreen({super.key, this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation')), 
      body: Center(
        child: flight == null
            ? const Text('No flight selected')
            : Text('Reserve seat for ${flight!.airline} ${flight!.flightNumber}'),
      ),
    );
  }
}
