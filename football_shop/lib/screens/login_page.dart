import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/providers/user_session.dart';
import 'package:football_shop/screens/menu_page.dart'; 
import 'package:football_shop/screens/registration_page.dart'; // ADDED

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login - Beyond The Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Selamat Datang!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan login untuk melanjutkan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true, 
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
              onPressed: () async { // CHANGED TO ASYNC
                String username = _usernameController.text;
                String password = _passwordController.text;

                if (username.isNotEmpty && password.isNotEmpty) {
                  final userSession = context.read<UserSession>();
                  bool success = await userSession.login(username, password);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Successful!'), backgroundColor: Colors.green));
                    // Navigasi ke menu utama dan hapus riwayat navigasi
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MenuPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: const Text('Login failed. Check your credentials.'),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                  }
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('Username dan Password tidak boleh kosong!'),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            // ADD REGISTRATION BUTTON
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
              },
              child: const Text('Don\'t have an account? Register here!', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}