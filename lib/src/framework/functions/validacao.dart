class ValidaCampos {
  bool validaEmail(String email) {
    return (email.contains("@") &&
        email.contains(".com") &&
        email != null &&
        email != '');
  }

  bool validaSenha(String senha) {
    return (senha.length >= 8 && senha != null);
  }

  bool validaTextField(String textField) {
    return (textField != "" && textField != null);
  }
}
