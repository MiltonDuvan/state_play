import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_play/src/pages/home/home_controller.dart';
import 'package:state_play/src/widgets/space_height_form.dart';

class EditCylinder extends StatelessWidget {
  final VoidCallback editCreate;
  final int? cylinderId;
  final int? cylinderWeight;
  final double? cylinderPrice;
  EditCylinder(
      {Key? key,
      required this.editCreate,
      this.cylinderId,
      this.cylinderWeight,
      this.cylinderPrice})
      : super(key: key);

  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.editWeight.value = cylinderWeight ?? 0;
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
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white
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
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis
                  .horizontal, // Esto permite que la lista sea horizontalmente scrollable
              child: Row(
                children: [
                  _optionGender('10 Libras', 10),
                  _optionGender('30 Libras', 30),
                  _optionGender('40 Libras', 40),
                  _optionGender('100 Libras', 100),
                ],
              ),
            ),
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
          ),
        ],
      ),
    );
  }

  ChoiceChip _optionGender(String label, int value) {
    bool isActive = _controller.editWeight.value == value;
    return ChoiceChip(
        shape: isActive
            ? const StadiumBorder(side: BorderSide(color: Colors.blueAccent))
            : const StadiumBorder(),
        label: Text(label,
            style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w300)),
        avatarBorder: CircleBorder(side: BorderSide(color: Colors.white)),
        selectedColor: Color(0xFFFFFFFF),
        selected: isActive,
        backgroundColor:
            isActive ? Color.fromARGB(255, 4, 2, 2) : Color(0xFFEEEEEE),
        onSelected: (bool selected) {
          if (selected) {
            _controller.updateWeight(value);
            print(_controller.editWeight.value);
          }
        });
  }
}
