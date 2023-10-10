import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SoldController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final cylindersSold = [].obs;

  @override
  onInit() {
    super.onInit();
    loadCylindersSold();
  }

  Future<void> loadCylindersSold() async {
    cylindersSold.value = await getCylindersSold();
  }

  soldCylinder(int weight) async {
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
    await saveData(weight);
  }

  Future<void> saveData(int weigth) async {
    Database database = await openDatabase('my_database.db');
    try {
      await database.insert(
          'solds',
          {
            'weight': weigth,
            'name': nameController.text,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('Cilindro vendido');
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

  goToSold() {
    Get.toNamed('/history_cylinder');
  }
}
