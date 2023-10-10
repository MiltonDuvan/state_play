import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_play/src/pages/sold/sold_controller.dart';

class SoldPage extends StatelessWidget {
  SoldPage({super.key});

  final SoldController soldController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Historial de cilindros vendidos  ',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Averta',
              fontWeight: FontWeight.w300),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (soldController.cylindersSold.isEmpty) {
                    return const Text('No hay cilindros  por el momento');
                  } else {
                    return Container(
                      color: Colors.amberAccent,
                      width: MediaQuery.of(context).size.width - 60,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        itemCount: soldController.cylindersSold.length,
                        itemBuilder: (context, index) {
                          return Text(
                              soldController.cylindersSold[index]['name']);
                        },
                      ),
                    );
                  }
                }),
              ],
            )
          ],
        ),
      )),
    );
  }

  // Widget cylinderHistory(BuildContext context) {
  //   return
  // }
}
