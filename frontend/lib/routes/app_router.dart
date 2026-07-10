import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Import semua page
import '../pages/auth/login_page.dart';
import '../pages/auth/register.dart';
import '../pages/user/dashboard_page.dart';
import '../pages/user/explore_page.dart';
import '../pages/user/messages_page.dart';
import '../pages/user/profile_page.dart';
import '../pages/user/settings_page.dart';
import '../pages/user/study_clubs_page.dart';
import '../pages/user/chat_page.dart';
import '../pages/user/scholarships_page.dart';
import '../pages/user/competitions_page.dart';
import '../pages/user/seminars_page.dart';
import '../pages/admin/admin_dashboard.dart';
import '../pages/admin/manage_events.dart';
import '../pages/admin/manage_scholarships.dart';
import '../pages/admin/manage_study_clubs.dart';
import '../pages/admin/manage_users.dart';

class AppRouter {
  // Guard untuk proteksi route admin
  static Widget _adminGuard(BuildContext context, Widget page) {
    if (!AuthService.isLoggedIn || !AuthService.isAdmin) {
      // Redirect ke login jika bukan admin
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Akses ditolak. Silakan login sebagai admin.'),
            backgroundColor: Colors.red,
          ),
        );
      });
      return const Center(child: CircularProgressIndicator());
    }
    return page;
  }

  // Daftar semua route
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // Auth routes
      '/login':    (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),

      // User routes
      '/dashboard':   (context) => const DashboardPage(),
      '/explore':     (context) => const ExplorePage(),
      '/messages':    (context) => const MessagesPage(),
      '/profile':     (context) => const ProfilePage(),
      '/settings':    (context) => const SettingsPage(),
      '/study-clubs': (context) => const StudyClubsPage(),
      '/chat':        (context) => const ChatPage(),
      '/scholarships': (context) => const ScholarshipsPage(),
      '/competitions': (context) => const CompetitionsPage(),
      '/seminars':     (context) => const SeminarsPage(),

      // Admin routes (dengan guard)
      '/admin/dashboard':    (context) => _adminGuard(context, const AdminDashboard()),
      '/admin/events':       (context) => _adminGuard(context, const ManageEvents()),
      '/admin/scholarships': (context) => _adminGuard(context, const ManageScholarshipsPage()),
      '/admin/study-clubs':  (context) => _adminGuard(context, const ManageStudyClubsPage()),
      '/admin/users':        (context) => _adminGuard(context, const ManageUsersPage()),
    };
  }

  // Tentukan halaman awal berdasarkan status login & role
  static String getInitialRoute() {
    if (!AuthService.isLoggedIn) return '/login';
    if (AuthService.isAdmin) return '/admin/dashboard';
    return '/dashboard';
  }
}
