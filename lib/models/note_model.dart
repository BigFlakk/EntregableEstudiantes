// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  int? id;
  String nombre;
  String edad;

  Note({
    required this.id,
    required this.nombre,
    required this.edad,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        nombre: json["nombre"],
        edad: json["edad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "edad": edad,
      };
}
