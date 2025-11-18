import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:football_shop/providers/user_session.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController(); // Untuk konfirmasi

  @override
  Widget build(BuildContext context) {
    final userSession = context.read<UserSession>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register - Beyond The Game'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Buat Akun Baru',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 48),

              TextFormField(
                controller: _usernameController,
                decoration: _buildInputDecoration('Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: _buildInputDecoration('Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _password2Controller,
                obscureText: true,
                decoration: _buildInputDecoration('Confirm Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi password tidak boleh kosong!';
                  }
                  if (value != _passwordController.text) {
                    return 'Password tidak cocok!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    String password2 = _password2Controller.text;

                    final response = await userSession.post(
                      '/api/register/', // Endpoint API register Django
                      {'username': username, 'password': password, 'password2': password2},
                    );

                    final data = json.decode(response.body);

                    if (response.statusCode == 200 && data['success'] == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration successful! Please log in.'), backgroundColor: Colors.green),
                      );
                      Navigator.pop(context); // Kembali ke halaman login
                    } else {
                      String message = data['message'] ?? 'Registration failed.';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
                      );
                    }
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman login
                },
                child: const Text('Already have an account? Login here!', style: TextStyle(color: Colors.white70)),
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
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}