import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SoldController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  soldCylinder(int weight) async {
    if (nameController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Nombre es obligatorios',
        duration: Duration(seconds: 4),
      ));
      return;
    }
    await saveData(weight);
  }

  Future<void> saveData(int weigth) async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE solds(id INTEGER PRIMARY KEY, weight INTEGER, name TEXT)',
        );
      },
      version: 1,
    );

    try {
      await database.insert(
          'solds',
          {
            'weight': weigth,
            'name': nameController.text,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('Cylinder sold');
    } catch (e) {
      print('Error al vender $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Ocurrio un error al guardar el cilindro',
        duration: Duration(seconds: 4),
      ));
    }
  }

  
  goToSold(){
    Get.toNamed('/sold');
  }
}
