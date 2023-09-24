import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:state_play/src/pages/edit_create_cylinder/edit_cylinder.dart';

class HomeController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  RxInt totalCylinders = 0.obs;
  //DropdownMenuItem
  RxList<int> weightList = <int>[30, 40, 100].obs;
  RxInt valueDropdown = 40.obs;

  @override
  void onInit() {
    super.onInit();
    getCylinders().then((cilynders) {
      totalCylinders.value = cilynders.length;
      update();
    });
  }

  addCylinder() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
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
          'weight': valueDropdown.value,
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

  Future<void> editCylinder(int id) async {
    try {
      Database database = await openDatabase(
          join(await getDatabasesPath(), 'my_database.db'),
          version: 1);

      final Map<String, dynamic> updatedValues = {};

      if (nameController.text.isNotEmpty) {
        updatedValues['name'] = nameController.text;
      }
      if (weightController.text.isNotEmpty) {
        updatedValues['weight'] = weightController.text;
      }
      if (priceController.text.isNotEmpty) {
        updatedValues['price'] = double.parse(priceController.text);
      }

      if (updatedValues.isNotEmpty) {
        await database.update('cylinders', updatedValues,
            where: 'id = ?',
            whereArgs: [id],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await database.close();

      Get.showSnackbar(const GetSnackBar(
        message: 'Cilindro actualizado',
        duration: Duration(seconds: 4),
      ));

      goToHome();
    } catch (e) {
      print('Error editar cilynder: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Ocurrio un error al editar el cilindro',
        duration: Duration(seconds: 4),
      ));
    }
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

  void goToAddCylinder() {
    Get.toNamed('/add_cylinder');
  }
}
