import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // We'll use Google Fonts for a nicer look

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a dark theme for a more "premium shop" feel
    return MaterialApp(
      title: 'Football Shop',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF121212), // A deep dark grey
        fontFamily: GoogleFonts.poppins().fontFamily, // Use Poppins for all text
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F), // Slightly lighter grey for app bar
          elevation: 0, // No shadow
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Helper function to show the SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any old snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F1F1F),
        behavior: SnackBarBehavior.floating, // Make it float above the bottom
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beyond The Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // More padding around the edges
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Title Text ---
              const Text(
                'Welcome, You',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'What do you want to do today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 48), // More space before buttons

              // --- Button 1: All Products ---
              _ShopButton(
                text: 'All Products',
                icon: Icons.shopping_bag_outlined,
                color: Colors.blueAccent,
                onPressed: () {
                  _showSnackBar(context, 'Kamu telah menekan tombol All Products');
                },
              ),
              const SizedBox(height: 16),

              // --- Button 2: My Products ---
              _ShopButton(
                text: 'My Products',
                icon: Icons.person_pin_rounded,
                color: Colors.green,
                onPressed: () {
                  _showSnackBar(context, 'Kamu telah menekan tombol My Products');
                },
              ),
              const SizedBox(height: 16),

              // --- Button 3: Create Product ---
              _ShopButton(
                text: 'Create Product',
                icon: Icons.add_shopping_cart,
                color: Colors.redAccent,
                onPressed: () {
                  _showSnackBar(context, 'Kamu telah menekan tombol Create Product');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- A custom, reusable Button Widget for a cleaner look ---
class _ShopButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ShopButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // The required color
        foregroundColor: Colors.white, // White text/icon
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        elevation: 5, // Add a subtle shadow
      ),
      onPressed: onPressed,
    );
  }
}