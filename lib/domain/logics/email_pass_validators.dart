import 'validators.dart';

mixin EmailPassValidators {
  String? validateEmail(String? email) {
    return Validators.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return Validators.validatePassword(password);
  }
}
