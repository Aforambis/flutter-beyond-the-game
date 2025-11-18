import 'package:uuid/uuid.dart';
import 'dart:convert'; 

var uuid = const Uuid();

class Product {
  final String id;
  final int user;
  final int auctionSeason;
  
  final String name;
  final String description;
  final double startPrice;  
  final String? thumbnail;
  final String category;
  final bool isFeatured;  

  Product({
    required this.user,
    required this.auctionSeason,
    required this.name,
    required this.description,
    required this.startPrice,
    this.thumbnail,
    required this.category,
    this.isFeatured = false, 
  }) : id = uuid.v4();

  factory Product.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'];
    
    double parsePrice(dynamic value) {
      if (value is String) return double.tryParse(value) ?? 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return 0.0;
    }

    return Product(
      id: json['pk']?.toString() ?? uuid.v4(),
      user: fields['user'] ?? 0, 
      auctionSeason: fields['auction_season'] ?? 0,
      name: fields['name'] ?? 'No Name',
      description: fields['description'] ?? 'No Description',
      // Gunakan start_price dari Django
      startPrice: parsePrice(fields['start_price'] ?? 0.0), 
      thumbnail: fields['thumbnail'],
      category: fields['category'] ?? 'other',
      isFeatured: fields['is_featured'] ?? false,
    );
  }
}

class ProductStorage {
  static final List<Product> products = [];
}