import 'package:flutter/material.dart';
import 'package:insttantt_test/modules/contacts/provider/contacts_provider.dart';
import 'package:insttantt_test/shared/widgets/insttant_texfield_widget.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _id = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController dniController = TextEditingController();

  bool get _isFormValid {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Contacto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InsttantTexfieldWidget(
                maxLength: 50,
                hintText: 'Nombre de contacto',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre del contacto es requerido.';
                  } else if (value.length < 2) {
                    return 'El nombre del contacto debe tener al menos 2 caracteres.';
                  } else if (RegExp(r'\d').hasMatch(value)) {
                    return 'El nombre del contacto no puede contener números.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              InsttantTexfieldWidget(
                maxLength: 10,
                hintText: 'Identificación del contacto',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La identificación es requerida.';
                  } else if (value.length < 6) {
                    return 'La identificación debe tener al menos 6 caracteres.';
                  } else if (value.length > 10) {
                    return 'La identificación no puede tener más de 10 caracteres.';
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'La identificación debe contener solo números.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _id = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isFormValid
                    ? () async {
                        await contactsProvider.addContact(_name, _id);
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('Guardar Contacto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
