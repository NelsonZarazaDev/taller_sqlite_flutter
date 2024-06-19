import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:taller_sqlite_flutter/data_base/tables.dart';

class Db {
  String name = "DiaryApp";
  int version = 1;

//Future es como el fect es asincrono
  Future<Database> open() async {
    //join une una ruta con otra
    //
    String path = join(await getDatabasesPath(), name);
    return openDatabase(path,
        version: version,
        onConfigure: onConfigure,
        //Si vamos a onCreate con ctrl+click  y a OnDatabaseCreateFn de la misma manera nos dice que necesitamos pasar
        onCreate: onCreate);
  }

//Como tenemos un Future necesitamos colocar async para que espere
  onConfigure(Database db) async {
    //Las llaves foraneas vienen bloqueadas en sqlite necesitamos activarlas
    db.execute("PRAGMA foreign_keys = ON");
  }

//Aca vamos a crear las tablas, debe ser asincrona es decir que espere para ejecutarse
  onCreate(Database db, int version) async {
    for (var scrip in tables) {
      //execute se usa como ejecuta este script sql
      await db.execute(scrip);
    }
  }
}
