import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserSession extends ChangeNotifier {
  // Base URL dari Django yang sudah di-deploy
  static const String baseUrl = 'https://rusydan-mujtaba-beyondthegame.pbp.cs.ui.ac.id';
  
  // Variabel untuk menyimpan sessionid
  String _sessionCookie = ''; 
  bool _isLoggedIn = false;
  
  bool get isLoggedin => _isLoggedIn;

  void _updateSessionCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      // Cari dan ekstrak sessionid
      int index = rawCookie.indexOf('sessionid=');
      if (index != -1) {
        String sessionCookie = rawCookie.substring(index);
        int endIndex = sessionCookie.indexOf(';');
        if (endIndex != -1) {
          sessionCookie = sessionCookie.substring(0, endIndex);
        }
        _sessionCookie = sessionCookie;
        _isLoggedIn = true;
        notifyListeners();
      }
    }
  }

  // --- Implementasi GET Request (Memastikan cookie dikirim) ---
  Future<http.Response> get(String url) async {
    final uri = Uri.parse('$baseUrl$url');
    final headers = <String, String>{};
    if (_sessionCookie.isNotEmpty) {
      headers['Cookie'] = _sessionCookie;
    }
    return http.get(uri, headers: headers);
  }

  // --- Implementasi POST Request (Memastikan cookie dikirim dan diperbarui) ---
  Future<http.Response> post(String url, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$url');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_sessionCookie.isNotEmpty) {
      headers['Cookie'] = _sessionCookie;
    }
    
    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(data),
    );

    // Perbarui cookie setelah request (penting untuk login/register)
    _updateSessionCookie(response);
    
    return response;
  }

  // --- Autentikasi Menggunakan Endpoint API Django yang Sebenarnya ---
  Future<bool> login(String username, String password) async {
    final response = await post('/api/login/', { // Endpoint API login Django
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200 && json.decode(response.body)['success'] == true) {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    _isLoggedIn = false;
    notifyListeners();
    return false;
  }
  
  Future<void> logout() async {
    // Django logout endpoint
    await get('/logout/'); 
    _sessionCookie = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}