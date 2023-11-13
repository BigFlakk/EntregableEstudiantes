import 'package:flutter/material.dart';

class Student {
  final int? id;
  final String nombre;
  final String edad;

  Student({required this.id, required this.nombre, required this.edad});
}

class DetailsScreen extends StatelessWidget {
  final Student student;

  const DetailsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Estudiante'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Id del Estudiante: ${student.id}'),
            Text('Nombre del Estudiante: ${student.nombre}'),
            Text('Edad del Estudiante: ${student.edad}'),
          ],
        ),
      ),
    );
  }
}
