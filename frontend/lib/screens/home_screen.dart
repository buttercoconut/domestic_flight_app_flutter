import 'package:flutter/material.dart';
import '../widgets/home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Domestic Flight App')),
      body: const Center(child: Text('Welcome to Domestic Flight App')),
    );
  }
}
