import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/providers/user_session.dart'; // ADDED
import 'package:football_shop/screens/menu_page.dart';
import 'package:football_shop/screens/product_form_page.dart';
import 'package:football_shop/screens/product_list_page.dart';
import 'package:football_shop/screens/login_page.dart'; // ADDED

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userSession = context.read<UserSession>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1F1F1F),
            ),
            child: Column(
              children: [
                Text(
                  'Beyond The Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Catat semua produkmu di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuPage(),
                ),
              );
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk (Lokal)'),
            onTap: () {
              // Navigasi ke Halaman Form
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductFormPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text('Lihat Semua Produk (API)'),
            onTap: () {
                // Navigasi ke All Products List
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductListPage(isUserFiltered: false)),
                );
            },
          ),
          
          // ADDED: Logout Tile
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              userSession.logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully!'), backgroundColor: Colors.orange),
              );
              // Navigasi kembali ke halaman login dan hapus semua rute
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}