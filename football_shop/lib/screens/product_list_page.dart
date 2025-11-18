import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:football_shop/models/product.dart'; 
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/providers/user_session.dart';
import 'package:football_shop/screens/product_detail_page.dart'; 

class ProductListPage extends StatefulWidget {
  final bool isUserFiltered; // Flag untuk menentukan filter
  
  const ProductListPage({super.key, this.isUserFiltered = false});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  
  // Fungsi untuk mengambil data dari Django API
  Future<List<Product>> fetchProduct() async {
    final userSession = context.read<UserSession>();
    
    // Tentukan endpoint berdasarkan flag isUserFiltered
    String url = widget.isUserFiltered
        ? '/json/user/' // Endpoint baru untuk data produk user
        : '/json/'; // Endpoint untuk semua data

    final response = await userSession.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products. Status Code: ${response.statusCode} - ${response.body}');
    }

    // Decode JSON dan map ke List<Product>
    final List<dynamic> data = json.decode(response.body);
    List<Product> products = data.map((json) => Product.fromJson(json)).toList();

    return products;
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.isUserFiltered ? 'My Products (API)' : 'All Products (API)';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('Error: ${snapshot.error}', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              ),
            );
          }
          
          final List<Product> products = snapshot.data ?? [];
          
          if (products.isEmpty) {
            return Center(
              child: Text(
                widget.isUserFiltered ? 'You have no products listed.' : 'No products available.',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail saat item diklik (Checklist Item)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: const Color(0xFF1F1F1F),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display is_featured status
                          if (product.isFeatured)
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('⭐ FEATURED ITEM', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
                            ),
                          
                          // Display thumbnail (Checklist Item)
                          if (product.thumbnail != null && product.thumbnail!.isNotEmpty)
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
                          if (product.thumbnail != null && product.thumbnail!.isNotEmpty)
                            const SizedBox(height: 12),
                          
                          Text(
                            product.category.toUpperCase(), // Display category (Checklist Item)
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          
                          Text(
                            product.name, // Display name (Checklist Item)
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            'Starting Price \$${product.startPrice.toStringAsFixed(2)}', // Display price (Checklist Item)
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            product.description, // Display description (Checklist Item)
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
                  ),
                );
              },
            ),
    );
  }

