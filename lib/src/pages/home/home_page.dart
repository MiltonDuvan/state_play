import 'package:flutter/material.dart';
import 'package:state_play/src/widgets/cylinder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.add_box_outlined),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                )
              ],
            ),
            CylinderWidget()
          ],
        ),
      ),
    ));
  }
}
