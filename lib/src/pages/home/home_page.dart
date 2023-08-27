import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:state_play/src/pages/home/home_controller.dart';
import 'package:state_play/src/widgets/cylinder.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Cilindros '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Aquí puedes agregar un nuevo cilindro',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.038),
                ),
                const Icon(Icons.arrow_right),
                IconButton(
                    onPressed: () => alertFormAddCylinder(context),
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: MediaQuery.of(context).size.width * 0.08,
                      color: Colors.green,
                    )),
              ],
            ),
            spaceHeightForm(context),
            CylinderWidget(),
          ],
        ),
      ),
      bottomNavigationBar: _navigationBarHome(context),
    ));
  }

  Widget spaceHeightForm(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.032,
    );
  }

  Widget _navigationBarHome(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 4,
      height: MediaQuery.of(context).size.height * 0.07,
      color: const Color.fromARGB(210, 0, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total: ',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w300),
          ),
          Obx(
            () => Text(
              '${_controller.totalCylinders}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
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
              icon: const Icon(
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
            controller: _controller.nameController,
            decoration: InputDecoration(
              hintText: 'Nombre: Cilindro 1',
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.05,
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
            ),
          ),
          spaceHeightForm(context),
          TextField(
            controller: _controller.weightController,
            decoration: InputDecoration(
                hintText: 'Peso en libras: 40',
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.05,
                    maxWidth: MediaQuery.of(context).size.width * 0.75)),
          ),
          spaceHeightForm(context),
          TextField(
            controller: _controller.priceController,
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
                  onPressed: () {
                    _controller.addCylinder();
                  },
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
