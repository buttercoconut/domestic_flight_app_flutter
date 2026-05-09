import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:domestic_flight_app_flutter/models/flight.dart';

class ApiService {
  static const String _baseUrl = 'https://api.example.com';

  Future<List<Flight>> fetchFlights({
    String? origin,
    String? destination,
    String? date,
  }) async {
    final queryParameters = <String, String>{};
    if (origin != null) queryParameters['origin'] = origin;
    if (destination != null) queryParameters['destination'] = destination;
    if (date != null) queryParameters['date'] = date;

    final uri = Uri.parse('$_baseUrl/flights').replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => Flight.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load flights: ${response.statusCode}');
    }
  }
}
