import 'package:flutter/material.dart';
import '../models/airport.dart';

class AirportSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const AirportSearchField({Key? key, required this.controller, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.flight_takeoff),
      ),
    );
  }
}
