import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String _selectedFlight = '';

  void _reserve() async {
    if (_selectedFlight.isNotEmpty) {
      await ApiService.reserveFlight(_selectedFlight);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservation successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reserve Flight')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Flight ID'),
              onChanged: (value) => setState(() => _selectedFlight = value),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _reserve, child: const Text('Reserve')),
          ],
        ),
      ),
    );
  }
}
