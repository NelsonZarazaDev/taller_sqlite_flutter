import 'package:taller_sqlite_flutter/data_base/crud.dart';
import 'package:taller_sqlite_flutter/data_base/tables.dart';

class Diary extends Crud {
  //Creamos los mismo atributos que en la bd para poder usarlos
  int id;
  String type;
  String enterCode;
  //Se usa para indicar la tabla que vamos a utilizar y pasamos los atributos y inicializamos
  Diary({this.id = 0, this.type = "", this.enterCode = ""}) : super(diaryTable);

  @override
  String toString() {
    // TODO: implement toString
    return "\n Id: $id tipo: $type \n";
  }

  //Neccesitamos crear dos metodos, para generar el map al insertar y para pasar de map a object al obtenerlos
  // DE MAP A OBJETO
  Diary toObject(Map<dynamic, dynamic> data) {
    //En los corchetes debe ir el mismo atributo que en la bd para que lo reconozca
    return Diary(
        id: data["id"], type: data["type"], enterCode: data["enterCode"]);
  }

  //DE OBJETO A MAP
  Map<String, dynamic> toMap() {
    return {"id": id > 0 ? id : null, "type": type, "enterCode": enterCode};
  }

  save() async {
    return await ((id > 0) ? update(toMap()) : create(toMap()));
  }

  remove() async {
    await delete(id);
  }

//Como se van a almacenar varios diarios lo que se trae es una lista de varios diarios
  Future<List<Diary>> getDiaries() async {
    //Aca se aplica el rawQuery para hacer consultas lo mismo se puede aplicar en lso demas
    var result = await query("SELECT * FROM $diaryTable");
    return _getListObject(result);
  }

//No queremos una lista Map si no una lista de diarios de map a objeto
  List<Diary> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }

  checkEnterCode() async {
    //"OR 1=1 --" ESTO ES CODIGO MALICIOSO
    var result = await query(
        "SELECT * FROM $diaryTable WHERE id=? AND enterCode=?",
        arguments: [id, enterCode]);
    return toObject(result[0]);
  }
}
