class UserModel {
  final int id;
  final String name;
  final String email;
  final String role; // 'admin' atau 'user'

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  bool get isAdmin => role == 'admin';

  // Data dummy untuk testing
  factory UserModel.dummyAdmin() {
    return UserModel(
      id: 1,
      name: 'Administrator',
      email: 'admin@noera.id',
      role: 'admin',
    );
  }

  factory UserModel.dummyUser() {
    return UserModel(
      id: 2,
      name: 'Kakak Cica',
      email: 'user@noera.id',
      role: 'user',
    );
  }
}
