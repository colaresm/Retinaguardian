import 'package:flutter/material.dart';
import 'package:retinaguard/presentation/create_doctor/create_doctor_page.dart';
import 'package:retinaguard/presentation/home/home_page.dart';
import 'package:retinaguard/presentation/list_classifications/list_classifications_page.dart';
import 'package:retinaguard/presentation/login/login_page.dart';

redirectToHomePage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
    (route) => false,
  );
}

redirectToCrateDoctorPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CreateDoctorPage()),
  );
}

redirectToLoginPage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
    (route) => false,
  );
}

redirectToListClassificationsPage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const ListClassificationsPage()),
    (route) => false,
  );
}
