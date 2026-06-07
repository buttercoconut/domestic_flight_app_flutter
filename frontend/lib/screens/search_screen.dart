import 'package:flutter/material.dart';
import '../widgets/search_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Flights')),
      body: const Center(child: Text('Search Screen')),
    );
  }
}
