// Abstracta porque se va a estar heredando
import 'package:sqflite/sqflite.dart';
import 'package:taller_sqlite_flutter/data_base/db.dart';

abstract class Crud {
  String table;
  //Recibimos las tablas a la que le vamos a estar realizando las operaciones
  Crud(this.table);

  //Aca abrimos la db para hacer las operaciones CRUD
  Future<Database> get database async {
    return await Db().open();
  }

  //Aca esperamos a que   se realice la conexion y esperamos la bd
  //Con estas sentencias preparadas evitamos inyeccion de codigo malicioso
  query(String sql, {List<dynamic> arguments = const []}) async {
    //rawQuery nos permite agregar una consulta sqlite y asi poder manipular la bd
    //Hay dos maneras para poder realizar consultas una es rawQuery y query
    //RawQuery da seguridad ya que debemos pasar por variables y asi evitar inyecciones
    //En este caso podriamos pasar la consulta como lo hariamos en la linea de comandos sql
    return (await database).rawQuery(sql, arguments);
  }

//Se reciben los datos en data y como estamos recibiendo la tabla aca Crud(this.table); ya sabe a que tabla realizar las operaciones
  update(Map<String, dynamic> data) async {
    return (await database).update(table, data, where:"id=?", whereArgs: [data["id"]] );
  }

  create(Map<String, dynamic> data) async {
    return (await database).insert(table, data);
  }

  delete(int id) async {
    // Con rawDelete mandamos a eliminar como se haría comúnmente en bd
    // el signo de interrogación ayuda a que no coloquemos directamente el id
    return (await database).delete(table, where: "id = ?", whereArgs: [id]);
  }
}
