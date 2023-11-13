// ignore_for_file: unused_import, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/notes_provider.dart';
import 'package:notes_crud_local_app/screens/create_note_screen.dart';
import 'package:notes_crud_local_app/screens/details_screen.dart';
import 'package:notes_crud_local_app/screens/list_notes_screen.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';
import '../widgets/custom_navigatorbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Lista de Estudiantes")),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: _HomeScreenBody(),
        bottomNavigationBar: const CustomNavigatorBar());
  }
}

class _HomeScreenBody extends StatelessWidget {
  var id;

  var edad;

  get nombre => null;

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);

    int selectedOption = actualOptionProvider.selectedOption;

    switch (selectedOption) {
      case 0:
        return const ListNotesScreen();
      case 1:
        return const CreateNoteScreen();
      case 2:
        return DetailsScreen(
            student: Student(id: id, nombre: nombre, edad: edad));
      default:
        return const ListNotesScreen();
    }
  }
}
