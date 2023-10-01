import 'package:flutter/material.dart';

class SoldPage extends StatelessWidget {
  const SoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [const Text('Historial de cilindros vendidos'), 
          Container(
            width: MediaQuery.of(context).size.width - 20,      
            color: Colors.amberAccent,
          )],
        ),
      )),
    );
  }
  
}
