import 'package:flutter/material.dart';
import 'package:retinaguard/widgets/body.dart';

class ListClassificationsPage extends StatefulWidget {
  const ListClassificationsPage({super.key});

  @override
  State<ListClassificationsPage> createState() =>
      _ListClassificationsPageState();
}

class _ListClassificationsPageState extends State<ListClassificationsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Body(constraints: constraints, content: Container());
    });
  }
}
