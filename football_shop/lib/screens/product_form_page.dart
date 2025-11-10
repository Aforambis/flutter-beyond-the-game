import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart'; 
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _categories = [
    'Jersey',
    'Shoes',
    'Ball',
    'Artwork',
    'Other',
  ];
  String? _categoryValue;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _auctionSeasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _buildInputDecoration('Product Name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Product Name cannot be empty!";
                  }
                  if (value.length > 255) {
                    return "Product Name must not exceed 255 characters!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _startPriceController,
                decoration: _buildInputDecoration('Starting Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Starting Price cannot be empty!";
                  }
                  if (double.tryParse(value) == null) {
                    return "Starting Price must be a number!";
                  }
                  if (double.parse(value) < 0) {
                    return "Starting Price must not be negative!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _thumbnailController,
                decoration: _buildInputDecoration('Thumbnail URL (Optional)'),
                validator: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length > 255) {
                      return "Thumbnail URL must not exceed 255 characters!";
                    }
                    final urlPattern = RegExp(r'^https?:\/\/.*');
                    if (!urlPattern.hasMatch(value)) {
                      return "Thumbnail URL must be valid (must start with http:// or https://)!";
                    }
                  }
                  return null; 
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _auctionSeasonController,
                decoration: _buildInputDecoration('Auction Season ID'),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Season ID cannot be empty!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Season ID must be a number!";
                  }
                  if (int.parse(value) <= 0) {
                    return "Season ID must be a positive number!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: _buildInputDecoration('Category'),
                value: _categoryValue,
                hint: const Text('Select Category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoryValue = newValue;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Category must be selected!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _descriptionController,
                decoration: _buildInputDecoration('Description'),
                maxLines: 4,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty!";
                  }
                  if (value.length < 10) {
                    return "Description must be at least 10 characters long!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Product newProduct = Product(
                      name: _nameController.text,
                      startPrice: double.parse(_startPriceController.text),
                      description: _descriptionController.text,
                      thumbnail: _thumbnailController.text.isNotEmpty 
                                  ? _thumbnailController.text 
                                  : null, 
                      auctionSeason: int.parse(_auctionSeasonController.text),
                      category: _categoryValue!,
                      user: 1, 
                    );
                    
                    ProductStorage.products.add(newProduct);

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('Product "${newProduct.name}" has been saved successfully!'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white30),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      errorStyle: const TextStyle(color: Colors.redAccent),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}