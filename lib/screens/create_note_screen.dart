import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import '../providers/notes_provider.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CreateForm();
  }
}

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TblStudentProvider notesProvider =
        Provider.of<TblStudentProvider>(context);
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: notesProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: notesProvider.id.toString(),
            decoration: const InputDecoration(
              hintText: 'Ej:199928461',
              labelText: 'Documento de Estudiante',
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            onChanged: (value) {
              // Intenta convertir 'value' a int
              int? parsedValue = int.tryParse(value);

              // Asigna el valor convertido a 'notesProvider.id'
              if (parsedValue != null) {
                notesProvider.id = parsedValue;
              }
            },
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: notesProvider.nombre,
            decoration: const InputDecoration(
                hintText: 'Ej: Sebastian Escobar',
                labelText: 'Nombre Completo',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => notesProvider.nombre = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 6,
            autocorrect: false,
            initialValue: notesProvider.edad,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: '0-100',
              labelText: 'Edad',
            ),

            onChanged: (value) => notesProvider.edad = value,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 10),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: notesProvider.isLoading
                ? null
                : () {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!notesProvider.isValidForm()) return;

                    if (notesProvider.createOrUpdate == 'create') {
                      notesProvider.addNote();
                    } else {
                      notesProvider.updateNote();
                    }
                    notesProvider.resetNoteData();
                    notesProvider.isLoading = false;
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  notesProvider.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                )),
          )
        ],
      ),
    );
  }
}
