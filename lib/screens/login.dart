import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 167, 87, 1),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Mobile Number',
                filled: true, // Set filled to true
                fillColor: Colors.white, // Set background color to white
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true, // Set filled to true
                fillColor: Colors.white, // Set background color to white
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign in button press
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Handle login via OTP text press
              },
              child: Text('Login via OTP'),
            ),
            SizedBox(
                height:
                    8.0), // Add SizedBox to create space between the two text widgets
            GestureDetector(
              onTap: () {
                // Handle forgot password text press
              },
              child: Text('Forgot Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign up button press
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
