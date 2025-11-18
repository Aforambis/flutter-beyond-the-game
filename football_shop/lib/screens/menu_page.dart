import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/screens/product_form_page.dart';
import 'package:football_shop/screens/product_list_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1F1F1F),
        behavior: SnackBarBehavior.floating,
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
      drawer: const LeftDrawer(), 
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              const SizedBox(height: 48),

              _ShopButton(
                text: 'All Products (API)', // Renamed for clarity
                icon: Icons.shopping_bag_outlined,
                color: Colors.blueAccent,
                onPressed: () {
                  // Navigasi ke List Page, filter OFF
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductListPage(isUserFiltered: false)),
                  );
                },
              ),
              const SizedBox(height: 16),

              _ShopButton(
                text: 'My Products (API)', // Renamed for clarity
                icon: Icons.person_pin_rounded,
                color: Colors.green,
                onPressed: () {
                  // Navigasi ke List Page, filter ON
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductListPage(isUserFiltered: true)),
                  );
                },
              ),
              const SizedBox(height: 16),

              _ShopButton(
                text: 'Create Product (Lokal)', // Renamed for clarity
                icon: Icons.add_shopping_cart,
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductFormPage()),
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

class _ShopButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ShopButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      onPressed: onPressed,
    );
  }
}