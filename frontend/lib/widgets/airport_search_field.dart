import 'package:flutter/material.dart';

class AirportSearchField extends StatelessWidget {
  const AirportSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'From',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'To',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
