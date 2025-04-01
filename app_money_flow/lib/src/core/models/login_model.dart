class LoginModel {
  final String email;
  final String password;


  LoginModel({required this.email, required this.password});


  bool isValidEmail() {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}");
    return emailRegex.hasMatch(email);
  }


  bool isValidPassword() {
    final passwordRegex = RegExp(r"^\d{8}$");
    return passwordRegex.hasMatch(password);
  }
}
