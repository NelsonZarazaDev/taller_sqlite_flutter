//Esta es una tabla
const String diaryTable = "diary";

//Esta es otra tabla
const String pageTable = "page";

List get tables => [
      _createTable(
          diaryTable,
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "type TEXT,"
          "enterCode TEXT"),
      _createTable(
          pageTable,
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "date TEXT,"
          "title TEXT,"
          "content TEXT,"
          "diaryId INTEGER,"
          "FOREINGN KEY(diaryId) REFERENCES $diaryTable (id)")
    ];

// Si colocamos un guion bajo al inicio indica que es  privado y unicamente este  archivo lo puede usar
_createTable(String table, String colums) {
  // Si no existe la crea y le pasa las columnas
  return "CREATE TABLE IF NOT EXISTS $table ($colums)";
}
