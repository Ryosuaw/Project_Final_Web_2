import '../models/user_model.dart';

class AuthService {
  static UserModel? _currentUser;

  static UserModel? get currentUser => _currentUser;
  static bool get isLoggedIn => _currentUser != null;
  static bool get isAdmin => _currentUser?.isAdmin ?? false;

  // Login dengan data dummy
  static Future<bool> login(String email, String password) async {
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 500));

    // Cek kredensial admin
    if (email == 'admin@noera.id' && password == 'admin123') {
      _currentUser = UserModel.dummyAdmin();
      return true;
    }

    // Cek kredensial user biasa
    if (email == 'user@noera.id' && password == 'user123') {
      _currentUser = UserModel.dummyUser();
      return true;
    }

    // Login gagal
    return false;
  }

  static void logout() {
    _currentUser = null;
  }
}
