import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:state_play/src/pages/edit_create_cylinder/edit_cylinder.dart';
import 'package:state_play/src/pages/home/home_controller.dart';

class CylinderWidget extends StatelessWidget {
  CylinderWidget({super.key});
  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _controller.getCylinders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar datos');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No hay cilindros por el momento');
        } else {
          _controller.totalCylinders.value = snapshot.data!.length;
          return Container(
              color: Colors.white70,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 40,
              child: Wrap(
                spacing: 52.0,
                runSpacing: 40.0,
                children: List.generate(
                  _controller.totalCylinders.value,
                  (index) {
                    final cylindes = snapshot.data![index];
                    return listCylinders(context, cylindes, index);
                  },
                ),
              ));
        }
      },
    );
  }

  Widget listCylinders(BuildContext context, Map<String, dynamic> cylinder, int index) {
    NumberFormat numberFormat = NumberFormat('#,###');
    String priceFormat = numberFormat.format(cylinder['price']);
    int cilynderNumber = index + 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.check_circle,
              color: Color(0XFF00C535),
            )),
        Container(
            color: Colors.amberAccent,
            width: MediaQuery.of(context).size.width * 0.22,
            child: Text(
              'Cilindro $cilynderNumber',
              textAlign: TextAlign.center,
            )),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.075,
                    height: MediaQuery.of(context).size.width * 0.075,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      color: Color.fromARGB(140, 0, 0, 0),
                    ),
                    child: IconButton(
                      iconSize: MediaQuery.of(context).size.width * 0.038,
                      onPressed: () => alertDeleteCylinder(
                          context,
                          cylinder['id'],
                          'Eliminar',
                          '¿Estas seguro de eliminar este cilindro?',
                          () => _controller.deleteCilynder(cylinder['id'])),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  )
                ],
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () => alertDeleteCylinder(context, cylinder['id'], 'Editar',
              '¿Quieres editar este cilindro?', () {
        
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditCylinder(
                      editCreate: () {
                        _controller.editCylinder(cylinder['id']);
                      },
                      cylinderId: cylinder['id'],
                      cylinderWeight: cylinder['weight'],
                      cylinderPrice: cylinder['price']);
                });
          }),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${cylinder['weight']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'LB',
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: Text(
              '\$ $priceFormat',
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  Future<void> alertDeleteCylinder(BuildContext context, int id, String title,
          String descrption, VoidCallback onConfirmPressed) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Text(
                      descrption,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[350]),
                              onPressed: () => Get.back(),
                              child: const Text('Cancelar')),
                          ElevatedButton(
                              onPressed: onConfirmPressed,
                              child: const Text('Confirmar'))
                        ])
                  ],
                ),
              )));
}
