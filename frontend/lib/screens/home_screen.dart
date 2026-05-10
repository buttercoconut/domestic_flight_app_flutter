import 'package:flutter/material.dart';
import '../widgets/airport_search_field.dart';
import '../widgets/flight_card.dart';
import '../services/api_service.dart';
import 'reservation_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  List<Flight> _flights = [];
  bool _isLoading = false;

  Future<void> _searchFlights() async {
    setState(() => _isLoading = true);
    final flights = await ApiService.instance.searchFlights(
      from: _fromController.text,
      to: _toController.text,
    );
    setState(() {
      _flights = flights;
      _isLoading = false;
    });
  }

  int _selectedIndex = 0;
  static const List<Widget> _pages = [
    HomeScreen(),
    ReservationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Domestic Flights'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const AirportSearchField(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _searchFlights,
              icon: const Icon(Icons.search),
              label: const Text('Search Flights'),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _flights.length,
                      itemBuilder: (context, index) {
                        final flight = _flights[index];
                        return FlightCard(
                          flight: flight,
                          onBook: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReservationScreen(
                                flight: flight,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Flights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Reservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
