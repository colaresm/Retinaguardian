import 'package:flutter/material.dart';
import 'package:retinaguard/domain/use_cases/dependency_injection.dart';
import 'presentation/login/login_page.dart';

void main() {
  dependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 79, 168, 241),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            secondary: const Color.fromARGB(255, 75, 191, 79)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
