// lib/controllers/user_controller.dart
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  late Database _database;
  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final List<Map<String, dynamic>> userMaps = await _database.query('users');
    users.value = userMaps.map((map) => User.fromMap(map)).toList();
  }

  Future<void> insertUser(String name, int age) async {
    final user = User(name: name, age: age);
    await _database.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _fetchUsers();
  }
}
