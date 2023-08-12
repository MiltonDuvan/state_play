import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class HomeController extends GetxController {
  Future<void> _saveData() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cylinders(id INTEGER PRIMARY KEY, name TEXT, weight INTEGER, price DOUBLE)',
        );
      },
      version: 1,
    );

    await database.insert(
      'cylinders',
      {'name': 'Cilindro1', 'weight': '40', 'price': '50000'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Cylinder saved.');
    await database.close();
  }
}
