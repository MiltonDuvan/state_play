import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:state_play/src/global/global_var.dart';
import 'package:state_play/src/pages/home/home_controller.dart';

class SoldController extends GetxController {
  final HomeController homeController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final cylindersSold = [].obs;

  @override
  onInit() {
    super.onInit();
    loadCylindersSold();
  }

  void loadCylindersSold() async {
    final loadSoldCylinder = await getCylindersSold();
    cylindersSold.assignAll(loadSoldCylinder);
    update();
  }

  soldCylinder(int idOriginalCylinder, int weight, double priceOld) async {
    if (nameController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Nombre es obligatorio',
        duration: Duration(seconds: 4),
      ));
      return;
    }
    if (priceController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Precio es obligatorio',
        duration: Duration(seconds: 4),
      ));
      return;
    }
    await saveData(idOriginalCylinder, weight, priceOld);
    resetTextController();
    Get.back();
  }

  Future<void> saveData(
      int idOriginalCylinder, int weigth, double priceOld) async {
    Database database = await openDatabase('my_database.db');
    try {
      final originalCylinder = await database
          .query('cylinders', where: 'id = ?', whereArgs: [idOriginalCylinder]);
      if (originalCylinder.isNotEmpty) {
        await database.insert(
            'solds',
            {
              'name': nameController.text,
              'weight': weigth,
              'price_new': double.parse(priceController.text),
              'price_old': priceOld,
              'date_time': formattedDate,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
        //Elimina el cilindro de la tabla original
        await database.delete(
          'cylinders',
          where: 'id=?',
          whereArgs: [idOriginalCylinder],
        );
        print('Cilindro vendido y eliminado de la tabla original');
        //recarga la pagina Home y la pagina history con el metodo load...
        homeController.loadCylinders();
        loadCylindersSold();
        await database.close();
      } else {
        print('Cilindro no encontrado en la tabla original');
      }
    } catch (e) {
      print('Error al vender cilindro $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Ocurrio un error al guardar el cilindro',
        duration: Duration(seconds: 4),
      ));
    }
  }

  Future<List<Map<String, dynamic>>> getCylindersSold() async {
    Database database = await openDatabase('my_database.db');
    try {
      List<Map<String, dynamic>> result = await database.query('solds');
      await database.close();
      return result;
    } catch (e) {
      print('Error al listar los datos: $e');
      return [];
    }
  }

  void resetTextController() {
    nameController.text = '';
    priceController.text = '';
  }

  void goToSold() {
    Get.toNamed('/history_cylinder');
  }

  void goToDetailCylinder() {
    Get.toNamed('/detail_cylinder');
  }
}
