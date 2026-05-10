import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/airport.dart';
import '../models/flight.dart';

class ApiService {
  static const String baseUrl = 'https://api.example.com';

  Future<List<Airport>> fetchAirports() async {
    final response = await http.get(Uri.parse('$baseUrl/airports'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Airport.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load airports');
    }
  }

  Future<List<Flight>> searchFlights(
      String from, String to, DateTime date) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/flights?from=$from&to=$to&date=${date.toIso8601String()}'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Flight.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search flights');
    }
  }
}
