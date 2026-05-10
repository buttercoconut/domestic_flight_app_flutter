import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  final String _baseUrl = 'https://api.example.com';

  Future<List<Flight>> searchFlights({required String from, required String to}) async {
    final response = await http.get(Uri.parse('$_baseUrl/flights?from=$from&to=$to'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => Flight.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load flights');
    }
  }
}
