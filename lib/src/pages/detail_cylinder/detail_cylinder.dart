import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:state_play/src/pages/detail_cylinder/detail_cylinder_controller.dart';
import 'package:state_play/src/widgets/space_height_form.dart';

class DetailCylinderPage extends StatelessWidget {
  final int id;
  final String name;
  final String dateTime;
  final double purchasePrice;
  final double salePrice;
  final int weight;

  DetailCylinderPage(
      {super.key,
      required this.id,
      required this.name,
      required this.dateTime,
      required this.purchasePrice,
      required this.salePrice,
      required this.weight});

  final DetailCylinderController detailCylinderController =
      Get.put(DetailCylinderController());

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeOrg = DateTime.parse(dateTime);
    String formttedDate = DateFormat('d MMM y, HH:mm').format(dateTimeOrg);
    return GetBuilder<DetailCylinderController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SpaceHeightForm(),
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Averta',
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  const SpaceHeightForm(),
                  GestureDetector(
                    onPanUpdate: (details) {
                      detailCylinderController.updateOffset(details.delta);
                    },
                    child: Container(
                      color: Colors.amberAccent,
                      width: MediaQuery.of(context).size.width - 80,
                      height: MediaQuery.of(context).size.width * 0.6,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(
                              detailCylinderController.offset.dy * pi / 180)
                          ..rotateY(
                              detailCylinderController.offset.dx * pi / 180),
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/cilindro.png'),
                      ),
                    ),
                  ),
                  const SpaceHeightForm(),
                  const SpaceHeightForm(),
                  Text('Fecha y hora',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold)),
                  Text(formttedDate,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w300)),
                  const SpaceHeightForm(),
                  const SpaceHeightForm(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Precio compra',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold)),
                          Text('\$ $purchasePrice',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                      Column(
                        children: [
                          Text('Precio venta',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold)),
                          Text('\$ $salePrice',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.w300))
                        ],
                      )
                    ],
                  ),
                  const SpaceHeightForm(),
                  const SpaceHeightForm(),
                  const SpaceHeightForm(),
                    Text(weight.toString(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w300)),
                  Text('Libras',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _bottonNavigation(context),
        );
      },
    );
  }

  Widget _bottonNavigation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.15),
          child: GestureDetector(
            onTap: () => detailCylinderController.goToBack(),
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0XFF707070)),
              child: Center(
                  child: Text('Aceptar',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w300,
                          color: Colors.white))),
            ),
          ),
        ),
      ],
    );
  }
}
