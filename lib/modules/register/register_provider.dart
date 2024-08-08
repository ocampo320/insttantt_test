import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insttantt_test/models/user.dart';
import 'package:insttantt_test/repository/user_repository.dart';

class RegisterProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  String? _username;
  String? _email;
  String? _password;
  String? _confirmPassword;
  File? _userImage;

  bool _isFormValid = false;

  bool get isFormValid => _isFormValid;
  File? get userImage => _userImage;
  void updateUsername(String username) {
    _username = username;
    _validateForm();
  }

  void updateEmail(String email) {
    _email = email;
    _validateForm();
  }

  void updatePassword(String password) {
    _password = password;
    _validateForm();
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    _validateForm();
  }

  void _validateForm() {
    final usernameError = validateUsername(_username ?? '');
    final emailError = validateEmail(_email ?? '');
    final passwordError = validatePassword(_password ?? '');
    final confirmPasswordError =
        validateConfirmPassword(_confirmPassword ?? '', _password ?? '');

    _isFormValid = usernameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
    notifyListeners();
  }

  String? validateUsername(String value) {
    if (value.length < 4 || value.length > 50) {
      return 'El campo Nombre de usuario debe tener entre 4 y 50 caracteres.';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'El campo Nombre de usuario solo puede contener letras.';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.length < 6 || value.length > 50) {
      return 'El campo Correo de usuario debe tener entre 6 y 50 caracteres.';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Por favor ingrese un correo electrónico válido.';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 10 || value.length > 60) {
      return 'La contraseña debe tener entre 10 y 60 caracteres.';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,60}$')
        .hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra mayúscula, una letra minúscula, un número y un carácter especial.';
    }
    return null;
  }

  String? validateConfirmPassword(String value, String password) {
    if (value != password) {
      return 'Las contraseñas no coinciden.';
    }
    return null;
  }

  Future<void> register() async {
    if (_isFormValid) {
      if (_username != null && _email != null && _password != null) {
        final user = User(
          username: _username!,
          email: _email!,
          password: _password!,
        );

        try {
          await _userRepository.saveUser(user);
        } catch (e) {
          throw (e.toString());
        }
      }
    }
  }

  void setUserImage(String path) {
    _userImage = File(path);
    notifyListeners();
  }
}
