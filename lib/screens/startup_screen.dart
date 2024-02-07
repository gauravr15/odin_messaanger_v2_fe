import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:odin_messenger_v2/utils/api_interceptors.dart';
import 'package:odin_messenger_v2/utils/config.dart';
import 'package:odin_messenger_v2/screens/login.dart'; // Add this line

class StartupScreen extends StatefulWidget {
  final CustomHttpClient client; // Add this line

  StartupScreen({@required this.client}); // Add this constructor

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Simulating a network request delay
      await Future.delayed(Duration(seconds: 2));

      // Use the provided client to send a request
      final response = await widget.client.get(
        Uri.parse(AppConfig.config["apiVersionUrl"]),
        headers: {
          'env': AppConfig.config['appEnv'],
          'appVersion': AppConfig.config['appVersion'],
          'lang': AppConfig.config['appLang'],
        },
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the response JSON
        final data = json.decode(response.body);
        print('Response Data: $data');

        if (data['status'] == 'SUCCESS') {
          // Move to the login screen
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          // Show a pop-up dialog with a reload button
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Unable to connect to server'),
                content: Text(
                    'Please check your internet connection and try again.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      // Reload the data
                      fetchData();
                      Navigator.of(context).pop();
                    },
                    child: Text('Reload'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle the error case
        print('Failed to fetch data: ${response.statusCode}');
        // Show a pop-up dialog with a reload button
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Unable to connect to server'),
              content:
                  Text('Please check your internet connection and try again.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // Reload the data
                    fetchData();
                    Navigator.of(context).pop();
                  },
                  child: Text('Reload'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Exception: $e');
      // Show a pop-up dialog with a reload button
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Unable to connect to server'),
            content:
                Text('Please check your internet connection and try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Reload the data
                  fetchData();
                  Navigator.of(context).pop();
                },
                child: Text('Reload'),
              ),
            ],
          );
        },
      );
    } finally {
      // Set isLoading to false to hide the loading spinner
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 167, 87, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/brandLogo.png',
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
