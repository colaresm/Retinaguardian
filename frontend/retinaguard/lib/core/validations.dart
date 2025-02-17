String? requiredFiled(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo não pode estar vazio!';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Este campo não pode estar vazio!';
  }

  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return 'Email inválido';
  }
  return null;
}
