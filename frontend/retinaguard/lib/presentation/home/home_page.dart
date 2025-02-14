import 'package:flutter/material.dart';
import 'package:retinaguard/widgets/custom_elevated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
      ),
      backgroundColor: Colors.blue[500],
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:8.0),
                    child: Text(
                      "Bem vindo",
                      style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.9,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.06,
                  ),
                  CustomElevatedButton(
                      height: constraints.maxHeight * 0.06,
                      width: constraints.maxWidth * 0.9,
                      hintText: "Novo paciente",
                      onPressed: () {})
                ],
              ),
            ),
          ],
        );
      }),
      //  bottomNavigationBar: ,
    );
  }
}
