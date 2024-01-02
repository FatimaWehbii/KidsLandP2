import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
const String _baseURL = 'achenial-armfuls.000webhostapp.com';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> signUp() async {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    // Check if any of the fields is empty
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
      // Display an error message or show a dialog
      return;
    }

    // Hash the password (you can use a more secure method)
    final String hashedPassword = password;

    // Send data to the backend
    final signUpUri = Uri.https(_baseURL, 'signup.php');
    final Map<String, String> data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': hashedPassword,
    };

    try {
      final http.Response response = await http.post(signUpUri, body: data);

      // Handle the signup response
      if (response.statusCode == 200) {
        // Signup successful, you can handle the response accordingly
        print('Signup successful');
      } else {
        // Signup failed, display an error message
        // You can extract more information from the response if needed
        print('Signup failed: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions, e.g., network error
      print('Error during signup: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: signUp,
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                onPrimary: Colors.white,
              ),
              child: Text('Sign Up'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigate to the login page
                // You may want to pushReplacement to avoid stacking pages
              },
              child: Text('Already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
