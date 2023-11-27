import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class DetailCylinderController extends GetxController {
  Rx<Offset> _offset = Offset.zero.obs;
  Offset get offset => _offset.value;

  void updateOffset(Offset delta) {
    _offset.value += delta;
    update();
  }

  void resetPositionOffset(){
    _offset.value=Offset.zero;
    update();
  }

  void goToBack(){
    Get.back();
    resetPositionOffset();
  }
}
