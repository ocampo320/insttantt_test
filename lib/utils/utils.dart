class Utils {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo Nombre de usuario es obligatorio';
    } else if (value.length < 4) {
      return 'El nombre de usuario debe tener al menos 4 caracteres';
    } else if (value.length > 50) {
      return 'El nombre de usuario no debe exceder los 50 caracteres';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'El nombre de usuario solo puede contener letras';
    }
    return null;
  }
}

