import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail/Image
            if (product.thumbnail != null && product.thumbnail!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.thumbnail!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                        size: 80,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 24),

            // Name
            Text(
              product.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),

            // Category and Featured Status
            Row(
              children: [
                Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                if (product.isFeatured)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('⭐ FEATURED', style: TextStyle(color: Colors.yellow)),
                  ),
              ],
            ),
            const Divider(height: 32, color: Colors.white12),

            // Semua Atribut Ditampilkan (Sesuai Checklist)
            _buildDetailRow(
                'Starting Price',
                '\$${product.startPrice.toStringAsFixed(2)}',
                Colors.blueAccent),
            _buildDetailRow('Auction Season ID', product.auctionSeason.toString()),
            _buildDetailRow('Product ID', product.id),
            _buildDetailRow('User ID (Seller)', product.user.toString()),
            _buildDetailRow('Featured Status', product.isFeatured ? 'Yes' : 'No'),


            const SizedBox(height: 16),
            
            // Description
            const Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 48),

            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to List'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F1F1F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: valueColor ?? Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}