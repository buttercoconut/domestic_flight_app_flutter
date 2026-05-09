import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domestic_flight_app_flutter/models/flight.dart';
import 'package:domestic_flight_app_flutter/services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final flightListProvider = StateNotifierProvider<FlightListNotifier, AsyncValue<List<Flight>>>(
  (ref) => FlightListNotifier(ref.read),
);

class FlightListNotifier extends StateNotifier<AsyncValue<List<Flight>> {
  final Reader _read;

  FlightListNotifier(this._read) : super(const AsyncValue.loading()) {
    loadAllFlights();
  }

  Future<void> loadAllFlights() async {
    try {
      final flights = await _read(apiServiceProvider).fetchFlights();
      state = AsyncValue.data(flights);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchFlights({required String origin, required String destination, required String date}) async {
    try {
      state = const AsyncValue.loading();
      final flights = await _read(apiServiceProvider).fetchFlights(
        origin: origin,
        destination: destination,
        date: date,
      );
      state = AsyncValue.data(flights);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
