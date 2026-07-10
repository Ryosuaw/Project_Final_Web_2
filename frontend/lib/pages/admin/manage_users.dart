import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String major;
  final String role;
  final DateTime joinDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.major,
    required this.role,
    required this.joinDate,
  });
}

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy
    final users = [
      User(id: 1, name: 'Administrator', email: 'admin@noera.id', major: 'System Admin', role: 'Admin', joinDate: DateTime(2024, 1, 1)),
      User(id: 2, name: 'Kakak Cica', email: 'user@noera.id', major: 'Teknik Informatika', role: 'User', joinDate: DateTime(2024, 3, 15)),
      User(id: 3, name: 'Amanda Putri', email: 'amanda@student.ac.id', major: 'Teknik Informatika', role: 'User', joinDate: DateTime(2024, 4, 10)),
      User(id: 4, name: 'Budi Santoso', email: 'budi@student.ac.id', major: 'Sistem Informasi', role: 'User', joinDate: DateTime(2024, 5, 20)),
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
        ),
        title: const Text('Kelola Users', style: TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.primary),
            onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
            tooltip: 'Kembali ke Dashboard',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: user.role == 'Admin' ? AppColors.primaryContainer : AppColors.surfaceHigh,
                  child: Icon(
                    user.role == 'Admin' ? Icons.admin_panel_settings : Icons.person,
                    color: user.role == 'Admin' ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVar),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${user.major} • Bergabung ${user.joinDate.day}/${user.joinDate.month}/${user.joinDate.year}',
                        style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVar.withValues(alpha: 0.7)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: user.role == 'Admin' ? AppColors.primaryContainer.withValues(alpha: 0.1) : AppColors.surfaceLow,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    user.role,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: user.role == 'Admin' ? AppColors.primary : AppColors.onSurfaceVar,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
