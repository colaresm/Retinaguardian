import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color color;
  final double size;

  const CustomCard({
    Key? key,
    this.color = Colors.blue,
    this.size = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 60,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10),
                Icon(Icons.people),
                SizedBox(width: 20),
                Center(
                  child: Text(
                    "Irineu Andrade da Silva",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                 SizedBox(width: 30),
                Icon(Icons.edit),
                 SizedBox(width: 2),
                Icon(Icons.delete),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
