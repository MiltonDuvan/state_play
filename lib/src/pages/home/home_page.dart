import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
                IconButton(
                    onPressed: () => alertFormAddCylinder(context),
                    icon: const Icon(Icons.add_box_outlined)),
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

  Widget spaceHeightForm(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.032,
    );
  }

  Future alertFormAddCylinder(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: _formInserData(context),
            ),
          ));

  Widget _formInserData(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                size: 30,
              )),
          Text(
            'Agrega un cilindro',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          spaceHeightForm(context),
          spaceHeightForm(context),
          TextField(
            decoration: InputDecoration(
              hintText: 'Nombre: Cilindro 1',
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.05,
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
            ),
          ),
          spaceHeightForm(context),
          TextField(
            decoration: InputDecoration(
                hintText: 'Peso en libras: 40',
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.05,
                    maxWidth: MediaQuery.of(context).size.width * 0.75)),
          ),
          spaceHeightForm(context),
          TextField(
            decoration: InputDecoration(
                hintText: 'Precio: 72.000',
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.05,
                    maxWidth: MediaQuery.of(context).size.width * 0.75)),
          ),
          spaceHeightForm(context),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  child: const Text(
                    'Agregar Cilindro',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
