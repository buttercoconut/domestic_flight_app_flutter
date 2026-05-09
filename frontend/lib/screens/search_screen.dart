import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domestic_flight_app_flutter/models/flight.dart';
import 'package:domestic_flight_app_flutter/providers/flight_provider.dart';
import 'package:domestic_flight_app_flutter/widgets/flight_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _search() {
    final origin = _originController.text.trim();
    final destination = _destinationController.text.trim();
    final date = _dateController.text.trim();
    if (origin.isEmpty || destination.isEmpty || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    ref.read(flightListProvider.notifier).searchFlights(
      origin: origin,
      destination: destination,
      date: date,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Flights')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _originController,
              decoration: const InputDecoration(labelText: 'Origin'),
            ),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(labelText: 'Destination'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _search,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
