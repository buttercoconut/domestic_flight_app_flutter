import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../providers/airport_provider.dart';
import '../models/flight.dart';

final flightListProvider = StateNotifierProvider<FlightListNotifier, List<Flight>>((ref) {
  final api = ref.read(apiServiceProvider);
  return FlightListNotifier(api);
});

class FlightListNotifier extends StateNotifier<List<Flight>> {
  final ApiService api;
  FlightListNotifier(this.api) : super([]);

  Future<void> searchFlights(String from, String to, DateTime date) async {
    final flights = await api.searchFlights(from, to, date);
    state = flights;
  }
}
