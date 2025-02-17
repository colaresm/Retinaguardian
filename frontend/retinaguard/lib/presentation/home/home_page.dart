import 'package:flutter/material.dart';
import 'package:retinaguard/widgets/body.dart';
import 'package:retinaguard/widgets/custom_elevated_button.dart';

import 'widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Body(
        onRefresh: () {},
        constraints: constraints,
        content: Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.06,
            ),
            CustomElevatedButton(
            
                hintText: "Novo paciente",
                onPressed: () {}),
            Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth * 0.07,
                  right: constraints.maxWidth * 0.07),
              child: SizedBox(
                height: constraints.maxHeight * 0.6,
                width: constraints.maxWidth,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return CustomCard();
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
