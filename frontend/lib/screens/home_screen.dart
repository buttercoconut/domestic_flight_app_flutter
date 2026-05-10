import 'package:flutter/material.dart';
import '../widgets/flight_card.dart';
import '../services/api_service.dart';
import '../models/flight.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Flight> _flights = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _searchFlights();
  }

  Future<void> _searchFlights() async {
    setState(() => _loading = true);
    final flights = await _apiService.searchFlights(
      departure: 'ICN',
      arrival: 'KTX',
      date: DateTime.now(),
    );
    setState(() {
      _flights = flights;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Domestic Flights')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _flights.length,
              itemBuilder: (context, index) {
                return FlightCard(flight: _flights[index]);
              },
            ),
    );
  }
}
