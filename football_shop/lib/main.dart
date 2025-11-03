import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Shop',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Center the column in the middle of the screen
        child: Center(
          child: Column(
            // Arrange buttons vertically
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons fill the width
            children: [
              // --- Button 1: All Products ---
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_bag),
                label: const Text('All Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Blue color
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Show SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kamu telah menekan tombol All Products'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Spacer between buttons

              // --- Button 2: My Products ---
              ElevatedButton.icon(
                icon: const Icon(Icons.person_pin_rounded),
                label: const Text('My Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Green color
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Show SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kamu telah menekan tombol My Products'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Spacer between buttons

              // --- Button 3: Create Product ---
              ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Create Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red color
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Show SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kamu telah menekan tombol Create Product'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}