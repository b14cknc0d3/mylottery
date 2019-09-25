class Validators {
  static final RegExp _searchExp = RegExp(r'^[က-အ]{1,2}[၁-၉]{5,6}');
  static final RegExp _emailRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String username) {
    return _emailRegExp.hasMatch(username);
  }
  static isValidSearch(String text){
    return _searchExp.hasMatch(text);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
