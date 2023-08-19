import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:state_play/src/pages/home/home_controller.dart';

class CylinderWidget extends StatelessWidget {
  CylinderWidget({super.key});
  final HomeController _controller = HomeController();

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
          return Container(
              color: const Color.fromARGB(186, 253, 253, 253),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width -40,
              child: Wrap(
                spacing: 52.0,
                runSpacing: 40.0,
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    final cylindes = snapshot.data![index];
                    return listCylinders(context, cylindes);
                  },
                ),
              ));
        }
      },
    );
  }

  Widget listCylinders(BuildContext context, Map<String, dynamic> cylinder) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: Text(
              cylinder['name'],
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
                  IconButton(
                      onPressed: () => alertDeleteCilynder(context, cylinder['id']),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black54,
                      ))
                ],
              ),
            )
          ],
        ),
        Row(
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
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: Text(
              'Precio: ${cylinder['price']}',
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  Future alertDeleteCilynder(BuildContext context, int id) => showDialog(
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
                  'Eliminar cilindro',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  '¿Estas seguro de eliminar este cilindro?',
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
                      ElevatedButton(onPressed:() => _controller.deleteCilynder(id), child: const Text('Confirmar'))
                    ])
              ],
            ),
          )));
}
