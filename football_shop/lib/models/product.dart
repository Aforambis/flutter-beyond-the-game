class Product {
  final String name;
  final int price;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.description,
  });
}

class ProductStorage {
  static final List<Product> products = [];
}