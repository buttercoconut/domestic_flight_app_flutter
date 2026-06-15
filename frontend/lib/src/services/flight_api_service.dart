import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/flight.dart';

final flightApiProvider = Provider<FlightApiService>((ref) => FlightApiService());

class FlightApiService {
  final String baseUrl = 'https://api.example.com';

  Future<List<Flight>> fetchFlights({required String from, required String to, required DateTime date}) async {
    final uri = Uri.parse('$baseUrl/flights')
        .replace(queryParameters: {
      'from': from,
      'to': to,
      'date': date.toIso8601String(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Flight.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load flights');
    }
  }
}
