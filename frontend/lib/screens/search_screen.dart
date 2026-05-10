import 'package:flutter/material.dart';
import '../widgets/airport_search_field.dart';
import '../services/api_service.dart';
import '../models/flight.dart';
import '../widgets/flight_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  DateTime? _selectedDate;
  List<Flight> _results = [];
  bool _loading = false;

  Future<void> _search() async {
    if (_departureController.text.isEmpty || _arrivalController.text.isEmpty || _selectedDate == null) return;
    setState(() => _loading = true);
    final flights = await _apiService.searchFlights(
      departure: _departureController.text,
      arrival: _arrivalController.text,
      date: _selectedDate!,
    );
    setState(() {
      _results = flights;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Flights')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AirportSearchField(
              controller: _departureController,
              hint: 'Departure Airport',
            ),
            const SizedBox(height: 8),
            AirportSearchField(
              controller: _arrivalController,
              hint: 'Arrival Airport',
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'Select Date'
                      : '${_selectedDate!.toLocal()}'.split(' ')[0]),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() => _selectedDate = date);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _search, child: const Text('Search')),
            const SizedBox(height: 16),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return FlightCard(flight: _results[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
