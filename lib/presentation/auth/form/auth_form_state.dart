class AuthFormState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isLogin;

  const AuthFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isLogin = true,
  });

  AuthFormState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isLogin,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  bool get isValid =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      (emailError == null || emailError!.isEmpty) &&
      (passwordError == null || passwordError!.isEmpty);
}
