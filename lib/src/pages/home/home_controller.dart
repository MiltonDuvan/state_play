import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class HomeController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  RxInt totalCylinders = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCylinders().then((cilynders) {
      totalCylinders.value = cilynders.length;
      update();
    });
  }

  addCylinder() async {
    if (nameController.text.isEmpty ||
        weightController.text.isEmpty ||
        priceController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Todos los campos son obligatorios',
        duration: Duration(seconds: 4),
      ));
      return;
    }
    saveData();
  }

  Future<void> saveData() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cylinders(id INTEGER PRIMARY KEY, name TEXT, weight INTEGER, price DOUBLE)',
        );
      },
      version: 1,
    );

    try {
      await database.insert(
        'cylinders',
        {
          'name': nameController.text,
          'weight': int.parse(weightController.text),
          'price': double.parse(priceController.text)
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Cylinder saved.');
      await database.close();
      Get.offAllNamed('/home_page');
    } catch (e) {
      print('Error saving cilynder: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Ocurrio un error al guardar el cilindro',
        duration: Duration(seconds: 4),
      ));
    }
  }

  Future<List<Map<String, dynamic>>> getCylinders() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );
    List<Map<String, dynamic>> cylinders = await database.query('cylinders');
    await database.close();
    return cylinders;
  }

  Future<void> deleteCilynder(int id) async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );
    try {
      await database.delete('cylinders', where: 'id=?', whereArgs: [id]);
      print('Cilinder deleted');
      await database.close();
      goToHome();
    } catch (e) {
      print('error al eliminar: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Error al eliminar',
        duration: Duration(seconds: 4),
      ));
    }
  }

  void goToHome() {
    Get.offAllNamed('/home_page');
  }
}
