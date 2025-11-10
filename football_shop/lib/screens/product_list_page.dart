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
      body: products.isEmpty
          ? const Center(
              child: Text(
                'No products available.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
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
                        if (product.thumbnail != null &&
                            product.thumbnail!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.thumbnail!,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[800],
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.white54,
                                    size: 50,
                                  ),
                                );
                              },
                            ),
                          ),
                        if (product.thumbnail != null &&
                            product.thumbnail!.isNotEmpty)
                          const SizedBox(height: 12),
                        
                        Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
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
                          'Starting Price \$${product.startPrice.toStringAsFixed(2)}',
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
                          'Auction Season ID: ${product.auctionSeason} | User ID: ${product.user}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white54),
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