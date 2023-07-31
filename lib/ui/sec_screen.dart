import 'package:caching_data_examples/ui/first_screen.dart';
import 'package:flutter/material.dart';

class SecScreen extends StatelessWidget {
  const SecScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FirstScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
