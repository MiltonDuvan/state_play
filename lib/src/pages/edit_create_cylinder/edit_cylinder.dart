import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_play/src/pages/home/home_controller.dart';
import 'package:state_play/src/widgets/space_height_form.dart';

class EditCylinder extends StatelessWidget {
  final VoidCallback editCreate;
  final int? cylinderId;
  final String? cylinderName;
  final int? cylinderWeight;
  final double? cylinderPrice;
  EditCylinder(
      {Key? key,
      required this.editCreate,
      this.cylinderId,
      this.cylinderName,
      this.cylinderWeight,
      this.cylinderPrice})
      : super(key: key);

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
            'Editar cilindro',
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
              hintText: cylinderName,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.05,
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
            ),
          ),
          const SpaceHeightForm(),
          TextField(
            controller: _controller.weightController,
            decoration: InputDecoration(
                hintText: '$cylinderWeight Libras',
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.05,
                    maxWidth: MediaQuery.of(context).size.width * 0.75)),
          ),
          const SpaceHeightForm(),
          TextField(
            controller: _controller.priceController,
            decoration: InputDecoration(
                hintText: '\$ $cylinderPrice pesos',
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
                  onPressed: editCreate,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  child: const Text(
                    'Actualizar cilindro',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
