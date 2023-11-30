import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeController extends GetxController {
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  //listar cilindros
  RxBool loading = true.obs;
  RxList<Map<String, dynamic>> cylinders = <Map<String, dynamic>>[].obs;
  RxInt totalCylinders = 0.obs;

  int? quantity;
  //DropdownMenuItem
  RxList<int> weightList = <int>[10, 30, 40, 100].obs;
  RxInt valueDropdown = 40.obs;

  var editWeight = 0.obs;
  void updateWeight(int value) {
    editWeight.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    initializeDatabase();
    loadCylinders();
  }

  void loadCylinders() async {
    final loadedCylinders = await getCylinders();
    cylinders.assignAll(loadedCylinders);
    loading.value = false;
    totalCylinders.value = loadedCylinders.length;
    update();
  }

  late Database _database;
  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE cylinders(id INTEGER PRIMARY KEY, weight INTEGER, price DOUBLE)',
        );
        db.execute(
          'CREATE TABLE solds(id INTEGER PRIMARY KEY, name TEXT, weight INTEGER, price_old DOUBLE, price_new DOUBLE, date_time TEXT)',
        );
      },
      version: 1,
    );
  }

  addCylinder() async {
    if (quantityController.text.isEmpty || priceController.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Cantidad y precio son obligatorios',
        duration: Duration(seconds: 4),
      ));
      return;
    }
    quantity = int.parse(quantityController.text);

    // Guardar los cilindros
    for (int i = 0; i < quantity!; i++) {
      await saveData(_database);
    }
    resetTextController();
  }

  Future<void> saveData(Database database) async {
    Database database = await openDatabase('my_database.db');
    try {
      await database.insert(
        'cylinders',
        {
          'weight': valueDropdown.value,
          'price': double.parse(priceController.text)
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Cylinder saved.');
      loadCylinders();
      await _database.close();
    } catch (e) {
      print('Error saving cilynder: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Ocurrio un error al guardar el cilindro',
        duration: Duration(seconds: 4),
      ));
    }
  }

  Future<List<Map<String, dynamic>>> getCylinders() async {
    Database database = await openDatabase('my_database.db');
    List<Map<String, dynamic>> cylinders = await database.query('cylinders');
    return cylinders;
  }

  Future<void> editCylinder(int id) async {
    Database database = await openDatabase('my_database.db');
    try {
      final Map<String, dynamic> updatedValues = {};

      updatedValues['weight'] = editWeight.value;

      if (priceController.text.isNotEmpty) {
        updatedValues['price'] = double.parse(priceController.text);
      }

      if (updatedValues.isNotEmpty) {
        await database.update('cylinders', updatedValues,
            where: 'id = ?',
            whereArgs: [id],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      resetTextController();
      loadCylinders();
      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: 'Cilindro actualizado',
        duration: Duration(seconds: 4),
      ));
    } catch (e) {
      print('Error editar cilynder: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Ocurrio un error al editar el cilindro',
        duration: Duration(seconds: 4),
      ));
    } finally {
      await database.close();
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
      loadCylinders();
    } catch (e) {
      print('error al eliminar: $e');
      Get.showSnackbar(const GetSnackBar(
        message: 'Error al eliminar',
        duration: Duration(seconds: 4),
      ));
    } finally {
      await database.close();
    }
  }

  void resetTextController() {
    priceController.text = '';
    quantityController.text = '';
  }

  void goToHome() {
    Get.offAllNamed('/home_page');
  }

  void goToAddCylinder() {
    Get.toNamed('/add_cylinder');
  }

  void goToCylinderHistory() => Get.toNamed('/history_cylinder');
}
