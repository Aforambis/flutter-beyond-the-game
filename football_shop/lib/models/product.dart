import 'package:uuid/uuid.dart';

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

  Product({
    required this.user,
    required this.auctionSeason,
    required this.name,
    required this.description,
    required this.startPrice,
    this.thumbnail,
    required this.category,
  }) : id = uuid.v4(); 
}

class ProductStorage {
  static final List<Product> products = [];
}