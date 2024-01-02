import 'package:flutter/material.dart';
import 'AboutUs.dart';
import 'Login.dart';
import 'toys.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Kids Land',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
        actions: [

            Builder(
              builder: (context) => Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      AuthService.logout(context);
                    },
                  ),
                ],
              ),
            ),

        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
              ),
              child: Text(
                'Kids Land',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage ()),);
              },
            ),


          ],
        ),
      ),
      body:

      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/toysB.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to KIDSLAND',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.purpleAccent),

              ),
              SizedBox(height: 10),
              Text(
                'Providing kids toys',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.purple),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.purpleAccent,
                  primary: Colors.blue[200],
                  onPrimary: Colors.white,
                  shadowColor: Colors.purpleAccent,
                ),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),

    );
  }}
class AuthService {
  // ... existing code ...

  static Future<void> logout(BuildContext context) async {
    // Implement your logout logic here
    // This might include clearing user tokens, resetting session data, etc.

    // Example: clear SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}