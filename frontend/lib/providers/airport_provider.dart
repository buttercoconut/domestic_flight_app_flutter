import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/airport.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final airportListProvider = FutureProvider<List<Airport>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return await api.fetchAirports();
});
