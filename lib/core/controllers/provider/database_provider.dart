import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../managers/values.dart';

// this folder can be used with provider and riverpod

class DatabaseProvider extends ChangeNotifier {
  static DatabaseProvider get(BuildContext context) => Provider.of<DatabaseProvider>(context,listen: false);

  Database? database;

  void createDatabase() {
    openDatabase(
      "Notes.db",
      version: 1,
      onCreate: (database, version) {
        print("Database created");
        database.execute('''
        CREATE TABLE Notes (
          id INTEGER PRIMARY KEY,
          title TEXT,
          description TEXT
        )
      ''').then((value) {
          print("Notes table created");
        }).catchError((error) {
          print("Error in creating Notes table: $error");
        });
      },
      onOpen: (database) {
        print("Got database");
        getDatabase(database);
      },
    ).then((value) {
      database = value;
    }).catchError((error) {});
  }

  Future<void> addNote(
      {required String title, required String description, required BuildContext context}) async {
    database!.transaction((txn) {
      final values = {
        "title": title,
        "description": description,
      };

      return txn.insert("Notes", values).then((value) {
        print("item $value created ");
        getDatabase(database!);
        Navigator.pop(context);
      }).catchError((error) {
        print(error);
      });
    });
  }

  void getDatabase(Database database) {
    database.query("Notes").then((value) {
      notes = [];
      for (var element in value) {
        notes.add(element);
      }
      notifyListeners();
      print("got the data base items ");
      print("notes list length ${notes.length}");
    }).catchError((error) {
      print("error $error");
    });
  }

  Future<void> deleteNote({required BuildContext context, required int id}) async {
    database!.delete("Notes", where: "id = ?", whereArgs: [id]).then((value) {
      print("Note number $value deleted");
      getDatabase(database!);
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> update(BuildContext context,int id, String title, String description) async {
    final data = {
      "title": title,
      "description": description,
    };
    database!.database
        .update("Notes", data, where: "id = ?", whereArgs: [id]).then((value) {
          print(id);
          print("updated");

    });

    getDatabase(database!);
  }
}
