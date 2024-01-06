import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../managers/values.dart';
import 'db_state.dart';

class DbCubit extends Cubit<DbState> {
  DbCubit() : super(DbInitial());

  static DbCubit get(BuildContext context) => BlocProvider.of(context);

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
      emit(CreateDbDoneState());
    }).catchError((error) {
      emit(CreateDbErrorState());
    });
  }

  Future<void> addNote(
      {required String title, required String description}) async {
    emit(AddDbInitialState());
    database!.transaction((txn) {
      final values = {
        "title": title,
        "description": description,
      };

      return txn.insert("Notes", values).then((value) {
        print("item $value created ");
        getDatabase(database!);
        emit(AddDbDoneState());
      }).catchError((error) {
        print(error);
        emit(AddDbErrorState());
      });
    });
  }

  void getDatabase(Database database) {
    emit(GetDbLoadingState());
    database.query("Notes").then((value) {
      notes = [];
      for (var element in value) {
        notes.add(element);
      }

      print("got the data base items ");
      print("notes list length ${notes.length}");
      emit(GetDbDoneState());
    }).catchError((error) {
      print("error $error");
      emit(GetDbErrorState());
    });
  }

  Future<void> deleteNote({required int id}) async {
    emit(DeleteDbInitialState());
    database!.delete("Notes", where: "id = ?", whereArgs: [id]).then((value) {
      print("Note number $value deleted");
      getDatabase(database!);
      emit(DeleteDbDoneState());
    }).catchError((error) {
      print(error);
      emit(DeleteDbErrorState());
    });
  }

  Future<void> update(int id, String title, String description) async {
    emit(UpdateDbInitialState());
    final data = {
      "title": title,
      "description": description,
    };
    await database!.database
        .update("Notes", data, where: "id = ?", whereArgs: [id]);

    getDatabase(database!);
    emit(UpdateDbDoneState());
  }
}
