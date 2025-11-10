import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart'; 
import 'package:football_shop/widgets/left_drawer.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductStorage.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF1F1F1F),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Harga: ${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10), 
                  
                  Text(
                    'Ditambahkan: ${product.dateAdded.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                  Text(
                    'User ID: ${product.user}',
                    style: const TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}