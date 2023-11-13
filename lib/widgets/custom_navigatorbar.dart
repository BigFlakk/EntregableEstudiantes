// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:notes_crud_local_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final TblStudentProvider notesProvider =
        Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      //Current Index, para determinar el botón que debe marcarse
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          notesProvider.resetNoteData();
        }
        actualOptionProvider.selectedOption = i;
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.list),
            label: "Listar Estudiantes"),
        BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.post_add_rounded),
            label: "Crear Estudiante"),
        BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.list),
            label: "Detalles Estudiante"),
      ],
    );
  }
}
