import 'package:flutter/material.dart';
import 'package:odin_messenger_v2/screens/login.dart';
import 'package:odin_messenger_v2/utils/api_interceptors.dart';
import 'package:odin_messenger_v2/utils/config.dart';
import 'screens/startup_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  AppConfig.initializeConfig();
  CustomHttpClient client = CustomHttpClient();

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final CustomHttpClient client; // Use CustomHttpClient type here

  const MyApp({@required this.client});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/startup',
      routes: {
        '/startup': (context) => StartupScreen(client: client),
        '/login': (context) => LoginScreen(),
        // Add more routes as your app grows
        // '/home': (context) => HomeScreen(),
      },
    );
  }
}
