class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String username) {
    return _emailRegExp.hasMatch(username);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
