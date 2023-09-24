import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../widgets/space_height_form.dart';
import '../home/home_controller.dart';

class CreateCylinder extends StatelessWidget {
  CreateCylinder({super.key});
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: _formInserData(context),
      ),
    );
  }

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
          const SpaceHeightForm(),
          const SpaceHeightForm(),
          TextField(
            controller: _controller.nameController,
            decoration: InputDecoration(
              hintText: 'Nombre: Cilindro 1',
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.05,
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
            ),
          ),
          const SpaceHeightForm(),
          Row(mainAxisAlignment: MainAxisAlignment.start ,
            children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
               Text('Cantidad libras: ', style: TextStyle(fontFamily: ('Averta'), fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.w300),),
               SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
            ),
              _selectWeightWidget(),
            ],
          ),
          const SpaceHeightForm(),
          TextField(
            controller: _controller.priceController,
            decoration: InputDecoration(
                hintText: 'Precio: 72.000',
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.05,
                    maxWidth: MediaQuery.of(context).size.width * 0.75)),
          ),
          const SpaceHeightForm(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _controller.addCylinder(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  child: Text(
                    'Agregar Cilindro',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _selectWeightWidget() {
    return Obx(() => DropdownButton<int>(
          value: _controller.valueDropdown.value,
          onChanged: (int? newValue) {
            if (newValue != null) {
              _controller.valueDropdown.value = newValue;
            }
            print(_controller.valueDropdown);
          },
          items: _controller.weightList.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ));
  }
}
