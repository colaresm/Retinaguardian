import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Erro ao exibir dados".toUpperCase(),
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}
