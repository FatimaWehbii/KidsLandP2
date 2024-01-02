import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
const String _baseURL = 'achenial-armfuls.000webhostapp.com';
class AuthService {
  static const String _tokenKey = 'user_token';
  static Future<bool> login(BuildContext context, String email, String password) async {

    // Replace this with your actual login logic
    // For example, you can make an HTTP request to your login API

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    // Replace 'https://your-login-api-url/login' with your actual login API endpoint
    final Uri loginUri = Uri.https(_baseURL, 'login.php');


    try {

      final response = await http.post(loginUri).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        // Replace this with your actual success condition
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['success'] == true) {
          // Save the token locally
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(_tokenKey, jsonResponse['token']);
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. Please check your credentials.')),
          );
          return false;
        }
      } else {
        // Replace this with your actual failure condition
        return false;
      }
    } catch (e) {
      // Handle any exceptions that might occur during the login request
      print('Login failed: $e');
      return false;
    }
  }static bool isLoggedIn() {
    // Check if the token exists
    final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
    final String? token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  static void logout() async {
    // Remove the token on logout
    final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
    await prefs.remove(_tokenKey);
  }
}
