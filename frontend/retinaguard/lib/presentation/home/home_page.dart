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
              height: constraints.maxHeight * 0.08,
            ),
            CustomElevatedButton(hintText: "Novo paciente", onPressed: () {}),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: constraints.maxWidth * 0.07,
                right: constraints.maxWidth * 0.07,
              ),
              child: SizedBox(
                height: constraints.maxHeight * 0.5,
                width: constraints.maxWidth,
                child: RawScrollbar(
                  thumbVisibility: true,
                  thumbColor: Theme.of(context).primaryColor,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return const CustomCard();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
