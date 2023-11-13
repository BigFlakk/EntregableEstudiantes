// ignore_for_file: depend_on_referenced_packages, avoid_print, unnecessary_nullable_for_final_variable_declarations

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../models/note_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Obteniendo direccion base donde se guardará la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Armamos la url donde quedará la base de datos
    final path = join(documentsDirectory.path, 'TblStudentDB.db');

    //Imprimos ruta
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {},
      onCreate: (db, version) async {
        await db.execute('''

        CREATE TABLE tblStudent(
          id INTEGER PRIMARY KEY,
          nombre TEXT,
          edad TEXT
        )

''');
      },
    );
  }

  Future<int> newNoteRaw(Note note) async {
    final int? id = note.id;
    final String nombre = note.nombre;
    final String edad = note.edad;

    final db =
        await database; //Recibimos instancia de base de datos para trabajar con ella

    final int res = await db.rawInsert('''

      INSERT INTO tblStudent (id, nombre, edad) VALUES ($id, "$nombre", "$edad")

''');
    print(res);
    return res;
  }

  Future<int> newNote(Note note) async {
    final db = await database;

    final int res = await db.insert("tblStudent", note.toJson());

    return res;
  }

  //Obtener un registro por id
  Future<Note?> getNoteById(int id) async {
    final Database db = await database;

    //usando Query para construir la consulta, con where y argumentos posicionales (whereArgs)
    final res = await db.query('tblStudent', where: 'id = ?', whereArgs: [id]);
    print(res);
    //Preguntamos si trae algun dato. Si lo hace
    return res.isNotEmpty ? Note.fromJson(res.first) : null;
  }

  Future<List<Note>> getAllTblStudent() async {
    final Database? db = await database;
    final res = await db!.query('tblstudent');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty ? res.map((n) => Note.fromJson(n)).toList() : [];
  }

  Future<int> updateNote(Note note) async {
    final Database db = await database;
    //con updates, se usa el nombre de la tabla, seguido de los valores en formato de Mapa, seguido del where con parametros posicionales y los argumentos finales
    final res = await db.update('tblstudent', note.toJson(),
        where: 'id = ?', whereArgs: [note.id]);
    return res;
  }

  Future<int> deleteNote(int id) async {
    final Database db = await database;
    final int res =
        await db.delete('tblstudent', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllTblStudent() async {
    final Database db = await database;
    final res = await db.rawDelete('''
      DELETE FROM tblstudent    
    ''');
    return res;
  }
}
