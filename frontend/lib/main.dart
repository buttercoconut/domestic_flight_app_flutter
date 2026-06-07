import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DomesticFlightApp());
}

class DomesticFlightApp extends StatelessWidget {
  const DomesticFlightApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domestic Flight App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
