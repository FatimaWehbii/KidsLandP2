import 'dart:convert';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'toys.dart';
const String _baseURL = 'achenial-armfuls.000webhostapp.com';
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _handleLogin(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    // API endpoint for your PHP script
    final signUpUri = Uri.https(_baseURL, 'login.php');

    try {
      final response = await http.post(
        signUpUri,
        body: {'email': email, 'password': password},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if the response body is not null or empty
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          // Check if the responseData has the expected fields
          if (responseData.containsKey('success') && responseData.containsKey('message')) {
            if (responseData['success']) {
              // Login successful, navigate to toys.dart
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToysList()),
              );
            } else {
              // Handle other cases based on the response
              print('Login failed: ${responseData['message']}');
            }
          } else {
            // Handle cases where the response data is missing expected fields
            print('Error: Unexpected response data structure');
          }
        } else {
          // Handle cases where the response body is null or empty
          print('Error: Unexpected null or empty response body');
        }
      } else {
        // Handle cases where the response status code is not 200
        print('Error: Unexpected response status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions (e.g., network error)
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login to explore and buy toys',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purpleAccent,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _handleLogin(context);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigation to SignUpPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }
}
