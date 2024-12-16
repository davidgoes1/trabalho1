import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 219, 95, 45),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 235, 170, 31),
        ),
      ),
      home: const Telalogin(),
    );
  }
}
