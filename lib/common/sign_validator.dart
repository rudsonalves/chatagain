// SignValidator class

class SignValidator {
  SignValidator._();

  static String? validateName(value) {
    final RegExp exp = RegExp(r"^([A-À-ÿ][a-z\-. ']+[ ])*");
    if (value.isEmpty) {
      return 'This field cannot be empty!';
    } else if (value.length < 3 || !exp.hasMatch(value)) {
      return 'This field must be at least 3 characters long!';
    }
    return null;
  }

  static String? validateEmail(value) {
    final RegExp exp = RegExp(r'^[\w-\.]+@[\w-\.]+\.[a-z]{2,3}');
    if (value!.isEmpty) {
      return 'This field cannot be empty!';
    } else if (!exp.hasMatch(value)) {
      return 'Enter a valid email address!';
    }

    return null;
  }

  static String? validatePassword(value) {
    final RegExp exp = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}');
    if (value!.length < 8 || !exp.hasMatch(value)) {
      return 'Must have at least 8 characters, 1 capital letter and 1 number.';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String firstValue, String secondValue) {
    if (validatePassword(firstValue) != null) {
      return 'Must have at least 8 characters, 1 capital letter and 1 number.';
    } else if (firstValue != secondValue) {
      return 'The passwords don\'t match!';
    }
    return null;
  }
}
