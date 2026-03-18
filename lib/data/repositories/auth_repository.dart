import '../../domain/repositories/auth_repository.dart';

class AuthRepository implements AuthRepositoryContract {
  /// Demo login: chấp nhận bất kỳ email/password nào
  /// Thành công nếu email có chứa '@' và password >= 6 ký tự
  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return email.contains('@') && password.length >= 6;
  }

  /// Demo register: tương tự login
  @override
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return email.contains('@') && password.length >= 6;
  }
}
