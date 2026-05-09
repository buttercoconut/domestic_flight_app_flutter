import 'package:flutter/material.dart';
import 'package:domestic_flight_app_flutter/models/flight.dart';
import 'package:domestic_flight_app_flutter/widgets/flight_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domestic_flight_app_flutter/providers/flight_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightListAsync = ref.watch(flightListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Domestic Flights'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: flightListAsync.when(
        data: (flights) {
          if (flights.isEmpty) {
            return const Center(
              child: Text('No flights found. Use search to find flights.'),
            );
          }
          return ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              return FlightCard(flight: flights[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
