import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/airport_provider.dart';
import '../providers/flight_provider.dart';
import '../widgets/airport_search_field.dart';
import '../widgets/flight_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airports = ref.watch(airportListProvider);
    final flights = ref.watch(flightListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search Flights',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AirportSearchField(
            airports: airports,
            onSearch: (from, to, date) {
              ref
                  .read(flightListProvider.notifier)
                  .searchFlights(from, to, date);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: flights.isEmpty
                ? const Center(child: Text('No flights found'))
                : ListView.builder(
                    itemCount: flights.length,
                    itemBuilder: (context, index) {
                      return FlightCard(flight: flights[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
