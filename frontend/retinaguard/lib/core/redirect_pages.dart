import 'package:flutter/material.dart';
import 'package:retinaguard/presentation/home/home_page.dart';

redirectToHomePage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
    (route) => false,
  );
}
