import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';



// this folder can be used with provider and riverpod

class DatabaseProvider extends ChangeNotifier {
  static DatabaseProvider get(BuildContext context) => Provider.of(context);

  Database? _database;

  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  Future<void> createDatabase() async {
    final database = await openDatabase(
      "Notes.db",
      version: 1,
      onCreate: (db, version) async {
        print("Database created");
        await db.execute('''
          CREATE TABLE Notes (
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT
          )
        ''');
        print("Notes table created");
      },
      onOpen: (db) async {
        print("Got database");
        _database = db;
        await getDatabase();
      },
    );
    _database = database;
    notifyListeners();
  }

  Future<void> addNote({
    required BuildContext context,
    required String title,
    required String description,
  }) async {
    _database!.transaction((txn) {
      final values = {
        "title": title,
        "description": description,
      };

      return txn.insert("Notes", values).then((value) {
        print("item $value created ");
        getDatabase();
        Navigator.pop(context);
      }).catchError((error) {
        print(error);
      });
    });
    notifyListeners();
  }

  Future<void> getDatabase() async {
    try {
      final value = await _database!.query("Notes");
      _notes = value;
      print("got the database items");
      print("notes list length ${_notes.length}");
    } catch (error) {
      print("error $error");
    }
    notifyListeners();
  }

  Future<void> deleteNote(BuildContext context, {required int id}) async {
    try {
      final value =
          await _database!.delete("Notes", where: "id = ?", whereArgs: [id]);
      print("Note number $value deleted");
      await getDatabase();
      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> update(BuildContext context,
      {required int id,
      required String title,
      required String description}) async {
    final data = {
      "title": title,
      "description": description,
    };

    try {
      final value = await _database!
          .update("Notes", data, where: "id = ?", whereArgs: [id]);
      print("Note number $value updated");
      await getDatabase();
      Navigator.pop(context);
      notifyListeners();
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
