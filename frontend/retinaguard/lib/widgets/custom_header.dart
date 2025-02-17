import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({required this.title, required this.subtitle, super.key});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        Text(
          subtitle.toUpperCase(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}
