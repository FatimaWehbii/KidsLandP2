import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.purple[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kids Land Store',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to the ""Kids Land" "Mobile App – a virtual wonderland where the joy of play meets the convenience of online shopping! Immerse yourself in a world of delightful toys and games curated to capture the hearts and imaginations of children everywhere.""Discover the Marvels:"
              "Upon launching the ""Kids Land" "app, you'll be greeted by a visually captivating interface adorned with playful colors and friendly characters. Our user-friendly design ensures a seamless and delightful shopping experience for both children and parents alike."

              "Safe and Secure:"
              "At ""Kids Land," "we prioritize the safety and security of your online experience. Our app is designed with robust safety measures, providing parents with peace of mind as they browse and make purchases."
              "Download the ""Kids Land""app today and embark on a journey where imagination knows no bounds. It's not just an online store; it's a digital playground where every tap opens the door to a world of wonder. Welcome to the Kids Land Mobile App – where the joy of childhood is just a touch away!",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Address: Nabatieh - Main Street',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Contact: KidsLand@gmail.com',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the main page
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}