import 'package:flutter/material.dart';

class SpaceHeightForm extends StatelessWidget {
  const SpaceHeightForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.032,
    );
  }
}