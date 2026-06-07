import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.example.com';

  static Future<List<String>> searchFlights(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/flights?search=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e['name'] as String).toList();
    } else {
      throw Exception('Failed to load flights');
    }
  }

  static Future<void> reserveFlight(String flightId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reservations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'flightId': flightId}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to reserve flight');
    }
  }
}
