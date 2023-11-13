// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';

import '../models/note_model.dart';
import 'db_provider.dart';

class TblStudentProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = 'create';
  int id = 0;
  String nombre = '';
  String edad = '';

  bool _isLoading = false;
  List<Note> tblstudent = [];

  // ignore: unnecessary_getters_setters
  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    return formKey.currentState?.validate() ?? false;
  }

  addNote() async {
    final Note note = Note(
      id: id.toInt(),
      nombre: nombre,
      edad: edad,
    );

    final res = await DBProvider.db.newNote(note);

    tblstudent.add(note);

    notifyListeners();
  }

  loadTblStudent() async {
    final List<Note> tblstudent = await DBProvider.db.getAllTblStudent();
    //operador Spreed
    this.tblstudent = [...tblstudent];
    notifyListeners();
  }

  updateNote() async {
    final note = Note(id: id, nombre: nombre, edad: edad);
    final res = await DBProvider.db.updateNote(note);
    print("Id actualizado: $res");
    loadTblStudent();
  }

  deleteNoteById(int id) async {
    final res = await DBProvider.db.deleteNote(id);
    loadTblStudent();
  }

  assignDataWithNote(Note note) {
    id = note.id!;
    nombre = note.nombre;
    edad = note.edad;
  }

  resetNoteData() {
    id = 0;
    nombre = '';
    edad = '';
    createOrUpdate = 'create';
  }
}
