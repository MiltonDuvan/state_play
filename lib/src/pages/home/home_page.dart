import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:state_play/src/pages/edit_create_cylinder/create_cylinder.dart';
import 'package:state_play/src/pages/home/home_controller.dart';
import 'package:state_play/src/widgets/cylinder.dart';
import 'package:state_play/src/widgets/space_height_form.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: const Text('Cilindros ', style: TextStyle(color: Colors.black),),
        leading:  IconButton(onPressed:() => _controller.goToCylinderHistory(), icon: Icon(Icons.history_rounded, size: MediaQuery.of(context).size.width * 0.08,color: Colors.black,)),
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateCylinder();
                          });
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: MediaQuery.of(context).size.width * 0.08,
                      color: Colors.green,
                    )),
              ],
            ),
            const SpaceHeightForm(),
            CylinderWidget(),
          ],
        ),
      ),
      bottomNavigationBar: _navigationBarHome(context),
    ));
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
}
