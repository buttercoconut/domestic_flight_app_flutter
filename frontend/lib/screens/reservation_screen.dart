import 'package:flutter/material.dart';
import '../widgets/reservation_screen.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation')),
      body: const Center(child: Text('Reservation Screen')),
    );
  }
}
