import 'package:flutter/material.dart';
import 'package:insttantt_test/modules/register/register_provider.dart';
import 'package:insttantt_test/shared/widgets/insttant_texfield_widget.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return InsttantTexfieldWidget(
                    validator: (value) => registerProvider.validateUsername(
                      value ?? '',
                    ),
                    hintText: 'Nombre de usuario',
                    keyboardType: TextInputType.text,
                    controller: _usernameController,
                    onChanged: (value) {
                      registerProvider.updateUsername(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return InsttantTexfieldWidget(
                    validator: (value) =>
                        registerProvider.validateEmail(value ?? ''),
                    hintText: 'Correo de usuario',
                    keyboardType:
                        TextInputType.emailAddress, // Corregir tipo de teclado
                    controller: _emailController,
                    onChanged: (value) {
                      registerProvider.updateEmail(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return InsttantTexfieldWidget(
                    validator: (value) =>
                        registerProvider.validatePassword(value ?? ''),
                    hintText: 'Contraseña',
                    obscureText: true,
                    controller: _passwordController,
                    onChanged: (value) {
                      registerProvider.updatePassword(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return InsttantTexfieldWidget(
                    validator: (value) =>
                        registerProvider.validateConfirmPassword(
                            value ?? '', _passwordController.text),
                    hintText: 'Confirmación de contraseña',
                    obscureText: true,
                    controller: _confirmPasswordController,
                    onChanged: (value) {
                      registerProvider.updateConfirmPassword(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 24.0),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          await registerProvider.register();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registro exitoso')),
                          );
                          Navigator.pop(context);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Error al registrar: $error')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, ingrese datos válidos.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Registrar'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
