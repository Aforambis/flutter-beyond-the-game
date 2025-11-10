class Product {
  final String name;
  final int price;
  final String description;
  final DateTime dateAdded;
  final int user;      

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.dateAdded,
    required this.user,
  });
}

class ProductStorage {
  static final List<Product> products = [];
}