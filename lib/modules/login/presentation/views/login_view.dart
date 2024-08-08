import 'package:flutter/material.dart';
import 'package:insttantt_test/modules/login/provider/login_provider.dart';
import 'package:insttantt_test/shared/widgets/insttant_texfield_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InsttantTexfieldWidget(
                hintText: 'Correo electronico',
                keyboardType: TextInputType.emailAddress,
                controller: _usernameController,
                onChanged: (value) {
                  authProvider.setUserName(value);
                },
              ),
              const SizedBox(height: 16.0),
              InsttantTexfieldWidget(
                hintText: 'Contreaseña',
                obscureText: true,
                controller: _passwordController,
                onChanged: (value) {
                  authProvider.setPassword(value);
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: authProvider.isFormValid
                    ? () async {
                        await authProvider.logIn();
                        if (authProvider.getIsLogin() == true && context.mounted) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(authProvider.getErrorMessages())),
                          );
                        }
                      }
                    : null,
                child: const Text('Ingresar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don\'t have an account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
