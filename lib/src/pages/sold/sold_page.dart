import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:state_play/src/global/global_var.dart';
import 'package:state_play/src/pages/detail_cylinder/detail_cylinder.dart';
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Vendido a        Precio        Fecha',
                      style: TextStyle(
                          fontFamily: 'Averta',
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.042),
                    )
                  ],
                ),
              ),
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
                        return cylinderHistory(
                          context,
                          soldController.cylindersSold[index]['id'],
                          soldController.cylindersSold[index]['name'],
                          soldController.cylindersSold[index]['price_old'],
                          soldController.cylindersSold[index]['price_new'],
                          soldController.cylindersSold[index]['date_time'],
                          soldController.cylindersSold[index]['weight']
                        );
                      },
                    ),
                  );
                }
              })
            ],
          ),
        ),
      )),
    );
  }

  Widget cylinderHistory(BuildContext context, int id, String name,double priceOld,
      double priceNew, String dateTime, int weight) {
    String priceFormat = numberFormat.format(priceNew);
    //formatear fecha
    DateTime dateTimeOrg = DateTime.parse(dateTime);
    String formttedDate = DateFormat('E d \'de\' MMM y').format(dateTimeOrg);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.082,
          width: MediaQuery.of(context).size.width * 0.25,
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              border: Border(right: BorderSide(width: 0.5))),
          child: Text(name.toUpperCase(),
              style: TextStyle(
                  fontFamily: 'Averta',
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.width * 0.042)),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.082,
          width: MediaQuery.of(context).size.width * 0.18,
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(width: 0.5))),
          child: Text('\$ $priceFormat',
              style: TextStyle(
                  fontFamily: 'Averta',
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.width * 0.038)),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.082,
          width: MediaQuery.of(context).size.width * 0.23,
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(width: 0.5))),
          child: Text(formttedDate,
              style: TextStyle(
                  fontFamily: 'Averta',
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.width * 0.038)),
        ),
        TextButton(
            onPressed: () => Get.to(DetailCylinderPage(id: id, name: name, dateTime: dateTime, purchasePrice: priceOld, salePrice: priceNew, weight: weight,)),
            child: const Text('Mostrar'))
      ],
    );
  }
}
