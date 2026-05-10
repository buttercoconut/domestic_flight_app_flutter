import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../widgets/flight_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _departureController = TextEditingController();
  final _arrivalController = TextEditingController();
  final _dateController = TextEditingController();
  List<dynamic> _flights = [];
  bool _loading = false;

  Future<void> _search() async {
    setState(() => _loading = true);
    final flights = await ApiService.instance.searchFlights(
      departure: _departureController.text,
      arrival: _arrivalController.text,
      date: _dateController.text,
    );
    setState(() {
      _flights = flights;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('항공편 검색')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _departureController,
              decoration: const InputDecoration(labelText: '출발지'),
            ),
            TextField(
              controller: _arrivalController,
              decoration: const InputDecoration(labelText: '도착지'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: '날짜'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _search, child: const Text('검색')),
            const SizedBox(height: 16),
            _loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _flights.length,
                      itemBuilder: (context, index) {
                        return FlightCard(flight: _flights[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
