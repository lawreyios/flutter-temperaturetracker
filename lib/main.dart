import 'package:flutter/material.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'pages/home_page.dart';

void main() {
  setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(
        title: "Are you well today?",
      ),
    );
  }
}
