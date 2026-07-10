import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () {
            // Cek role sebelum kembali
            final targetRoute = AuthService.isAdmin ? '/admin/dashboard' : '/dashboard';
            Navigator.pushReplacementNamed(context, targetRoute);
          },
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 8),
          _buildSettingsGroup('Akun & Keamanan', [
            _buildSettingsItem(Icons.lock_outline, 'Ubah Kata Sandi', 'Amankan akun Anda'),
            _buildSettingsItem(Icons.verified_user_outlined, 'Verifikasi Universitas', 'Unggah KTM atau bukti aktif'),
          ]),
          const SizedBox(height: 20),
          _buildSettingsGroup('Notifikasi', [
            _buildSettingsItem(Icons.notifications_none, 'Push Notifikasi', 'Aktif atau nonaktifkan notifikasi'),
            _buildSettingsItem(Icons.email_outlined, 'Email Notifikasi', 'Pengaturan info via email'),
          ]),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                AuthService.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text(
                'Keluar dari Akun',
                style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVar,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.onSurface, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.onSurfaceVar, fontSize: 11),
      ),
      trailing: const Icon(Icons.chevron_right, size: 16, color: AppColors.onSurfaceVar),
      onTap: () {},
    );
  }
}
