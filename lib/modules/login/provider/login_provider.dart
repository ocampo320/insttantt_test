import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insttantt_test/models/user.dart';
import 'package:insttantt_test/repository/user_repository.dart'; // Asegúrate de que el path sea correcto

class AuthProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  String _userName = '';
  String _email = '';
  String _password = '';
  String _errorMessages = '';
  File? _userImage;
  bool _isAuthenticated = false;
  bool _isLogin = false;

  bool get isAuthenticated => _isAuthenticated;
  String get userName => _userName;
  String get email => _email;
  File? get userImage => _userImage;
  bool get isFormValid {
    return _userName.isNotEmpty && _password.isNotEmpty;
  }

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setUserImage(String path) {
    _userImage = File(path);
    notifyListeners();
  }

  void setErrorMessages(String value) {
    _errorMessages = value;
  }

  String getErrorMessages() {
    return _errorMessages;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
  }

  bool getIsLogin() {
    return _isLogin;
  }

  Future<void> logout() async {
    _userName = '';
    _password = '';
    _userImage = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> logIn() async {
    _isLogin = await _userRepository.login(_userName, _password);
    User? user = await _userRepository.getAll(_userName);
    if (_isLogin) {
      _isAuthenticated = true;
      _userName = user!.username;
      _userImage = File(user.imagePath ?? '');
      setEmail(user.email);
      notifyListeners();
    } else {
      _isAuthenticated = true;
      _isLogin = false;
      setErrorMessages('Credenciales incorrectas');
    }
  }

  Future<void> updateUserImage(String path, String userName) async {
    try {
      final user = await _userRepository.getAll(userName);
      if (user != null) {
        final updatedUser = User(
          username: user.username,
          email: user.email,
          password: user.password,
          imagePath: path,
        );
        await _userRepository.saveUser(updatedUser);
        _userImage = File(path);
        notifyListeners();
      }
    } catch (e) {
      setErrorMessages(e.toString());
      rethrow;
    }
  }
}
