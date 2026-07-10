import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isDesktop = c.maxWidth >= 1024;
        final isTablet = c.maxWidth >= 768;

        return Scaffold(
          backgroundColor: AppColors.bg,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isDesktop) _sidebar(context),
              Expanded(
                child: Column(
                  children: [
                    if (!isDesktop) _mobileHeader(context),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20, isDesktop ? 32 : 80, 20, 100),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1280),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _hero(context, isTablet),
                                const SizedBox(height: 32),
                                _stats(),
                                const SizedBox(height: 32),
                                _adminCards(context, isDesktop),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: isDesktop ? null : _bottomNav(context),
        );
      },
    );
  }

  // ── SIDEBAR (Desktop) - Sama persis style-nya ───────────────────────────────

  Widget _sidebar(BuildContext context) {
    return Container(
      width: 288,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.outlineVar.withValues(alpha: 0.3))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Image.asset(
              'assets/logo.jpg',
              height: 32,
              width: 32,
              color: AppColors.surface,
              colorBlendMode: BlendMode.multiply,
              fit: BoxFit.contain,
              errorBuilder: (_, e, s) => const Icon(Icons.admin_panel_settings, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 8),
            const Text('NOERA ADMIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
          ]),
          const SizedBox(height: 40),
          _profileCard(),
          const SizedBox(height: 32),
          Expanded(child: _navList(context)),
          _bottomNavList(context),
        ],
      ),
    );
  }

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        const CircleAvatar(radius: 24, backgroundColor: AppColors.primaryContainer, child: Icon(Icons.admin_panel_settings, color: Colors.white, size: 24)),
        const SizedBox(width: 16),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Administrator', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          Text('Admin Panel', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
        ]),
      ]),
    );
  }

  Widget _navList(BuildContext context) {
    final items = [
      {'icon': Icons.dashboard, 'label': 'Dashboard', 'route': '/admin/dashboard', 'active': true},
      {'icon': Icons.event, 'label': 'Manage Events', 'route': '/admin/events'},
      {'icon': Icons.school, 'label': 'Scholarships', 'route': '/admin/scholarships'},
      {'icon': Icons.groups, 'label': 'Study Clubs', 'route': '/admin/study-clubs'},
      {'icon': Icons.people, 'label': 'Users', 'route': '/admin/users'},
    ];
    return ListView(
      padding: EdgeInsets.zero,
      children: items.map((i) => _navItem(
        context,
        i['icon'] as IconData,
        i['label'] as String,
        route: i['route'] as String,
        active: i['active'] == true,
      )).toList(),
    );
  }

  Widget _bottomNavList(BuildContext context) {
    return Column(children: [
      Divider(color: AppColors.outlineVar.withValues(alpha: 0.3)),
      const SizedBox(height: 16),
      _navItem(context, Icons.settings, 'Settings', route: '/settings'),
      _navItem(context, Icons.logout, 'Logout', route: '/login', isError: true, onLogout: () { AuthService.logout(); Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false); }),
    ]);
  }

  Widget _navItem(BuildContext context, IconData icon, String label, {
    required String route,
    bool active = false,
    bool isError = false,
    VoidCallback? onLogout,
  }) {
    final color = isError ? AppColors.error : (active ? Colors.white : AppColors.onSurfaceVar);
    final bgColor = isError ? AppColors.error.withValues(alpha: 0.1) : (active ? AppColors.primaryContainer : Colors.transparent);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onLogout ?? () {
            if (!active) Navigator.pushReplacementNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color, letterSpacing: 0.6)),
            ]),
          ),
        ),
      ),
    );
  }

  // ─── MOBILE HEADER ───────────────────────────────────────────────────────────

  Widget _mobileHeader(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Image.asset(
              'assets/logo.jpg',
              height: 28,
              width: 28,
              color: AppColors.surface,
              colorBlendMode: BlendMode.multiply,
              fit: BoxFit.contain,
              errorBuilder: (_, e, s) => const Icon(Icons.admin_panel_settings, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            const Text('NOERA ADMIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
          ]),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: () { AuthService.logout(); Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false); },
          ),
        ],
      ),
    );
  }

  // ── HERO SECTION - Adapted for Admin ────────────────────────────────────────

  Widget _hero(BuildContext context, bool isTablet) {
    final heroContent = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.onSurface, letterSpacing: -0.5),
          children: [
            TextSpan(text: 'Selamat datang, '),
            TextSpan(text: 'ADMINISTRATOR!', style: TextStyle(color: AppColors.primary)),
          ],
        ),
      ),
      const Offstage(child: Text('ADMINISTRATOR!')),
      const SizedBox(height: 4),
      const Text('Kelola events, beasiswa, dan pengguna dari panel ini.',
        style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVar)),
    ]);
    final buttons = Row(children: [
      _actionButton(Icons.add, 'Tambah Event', AppColors.primary, Colors.white,
        onTap: () => Navigator.pushNamed(context, '/admin/events')),
      const SizedBox(width: 12),
      _actionButton(Icons.school, 'Beasiswa', AppColors.inverseSurface, AppColors.inverseOnSurface,
        onTap: () => Navigator.pushNamed(context, '/admin/scholarships')),
    ]);
    if (isTablet) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: heroContent),
        const SizedBox(width: 16),
        buttons,
      ]);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      heroContent,
      const SizedBox(height: 16),
      buttons,
    ]);
  }

  Widget _actionButton(IconData icon, String label, Color bg, Color fg, {required VoidCallback onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6)),
      style: ElevatedButton.styleFrom(
        backgroundColor: bg, foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        elevation: 4,
      ),
    );
  }

  // ─── STATS - Admin version ───────────────────────────────────────────────────

  Widget _stats() {
    return Row(children: [
      Expanded(child: _statCard(Icons.event, '12', 'Total Events', AppColors.primaryFixed.withValues(alpha: 0.3))),
      const SizedBox(width: 12),
      Expanded(child: _statCard(Icons.school, '8', 'Beasiswa Aktif', AppColors.tertiaryContainer.withValues(alpha: 0.2))),
      const SizedBox(width: 12),
      Expanded(child: _statCard(Icons.people, '245', 'Total Users', AppColors.surfaceHigh)),
    ]);
  }

  Widget _statCard(IconData icon, String val, String label, Color iconBg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(24), // ← NOERA signature radius
        border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))],
      ),
      child: Row(children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: AppColors.primary, size: 24)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVar, letterSpacing: 0.6)),
        ]),
      ]),
    );
  }

  // ── ADMIN CARDS - Reusing opportunityCard pattern ───────────────────────────

  Widget _adminCards(BuildContext context, bool isDesktop) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 8, child: _mainAdminContent(context)),
          const SizedBox(width: 32),
          Expanded(flex: 4, child: _rightSidebar(context)),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mainAdminContent(context),
        const SizedBox(height: 32),
        _rightSidebar(context),
      ],
    );
  }

  Widget _mainAdminContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader(Icons.event, 'Events Terbaru', 'Kelola Semua', onTap: () => Navigator.pushNamed(context, '/admin/events')),
      const SizedBox(height: 16),
      SizedBox(
        height: 340,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _adminCard('EVENT', 'Career Fair 2025', 'Fakultas IT', ['15 Jun 2025', 'Auditorium'], 'Active', AppColors.primaryContainer),
            const SizedBox(width: 12),
            _adminCard('SEMINAR', 'AI & Machine Learning Workshop', 'HMTI', ['20 Jul 2025', 'Lab Komputer'], 'Upcoming', AppColors.tertiaryContainer),
            const SizedBox(width: 12),
            _adminCard('KOMPETISI', 'Hackathon Nasional 2025', 'Kemendikbud', ['10 Agt 2025', 'Online'], 'Draft', AppColors.surfaceHigh),
          ],
        ),
      ),
      const SizedBox(height: 32),
      _sectionHeader(Icons.school, 'Beasiswa Terbaru', 'Kelola Semua', onTap: () => Navigator.pushNamed(context, '/admin/scholarships')),
      const SizedBox(height: 16),
      LayoutBuilder(builder: (context, c) {
        final isLarge = c.maxWidth >= 600;
        final card1 = _scholarshipCard('Djarum Beasiswa Plus', 'Djarum Foundation', 'Rp 1.5M/Bulan', '28 Mei 2025', 'Open');
        final card2 = _scholarshipCard('Beasiswa Unggulan', 'Kemendikbud', 'Full Tuition', '31 Agt 2025', 'Open');
        if (isLarge) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: card1), const SizedBox(width: 12), Expanded(child: card2)]);
        } else {
          return Column(children: [card1, const SizedBox(height: 12), card2]);
        }
      }),
    ]);
  }

  Widget _sectionHeader(IconData icon, String title, String action, {required VoidCallback onTap}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [Icon(icon, color: AppColors.primary, size: 20), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.onSurface))]),
      GestureDetector(
        onTap: onTap,
        child: const Row(children: [
          Text('Lihat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary, letterSpacing: 0.6)),
          Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
        ]),
      ),
    ]);
  }

  // Admin card - reuse opportunityCard structure
  Widget _adminCard(String type, String title, String org, List<String> info, String status, Color typeBg) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: typeBg, borderRadius: BorderRadius.circular(99)), child: Text(type, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 0.5))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Active' ? Colors.green.withValues(alpha: 0.1) : (status == 'Upcoming' ? AppColors.primaryFixed : AppColors.surfaceLow),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: status == 'Active' ? Colors.green : (status == 'Upcoming' ? AppColors.primary : AppColors.onSurfaceVar))),
          ),
        ]),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
        const SizedBox(height: 8),
        Row(children: [const Icon(Icons.business, size: 16, color: AppColors.onSurfaceVar), const SizedBox(width: 8), Text(org, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar))]),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: info.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(8)), child: Text(t, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)))).toList()),
        Container(height: 1, color: AppColors.outlineVar.withValues(alpha: 0.3), margin: const EdgeInsets.symmetric(vertical: 12)),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 10)), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
          const SizedBox(width: 8),
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)))),
        ]),
      ]),
    );
  }

  Widget _scholarshipCard(String title, String provider, String amount, String deadline, String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: status == 'Open' ? Colors.green.withValues(alpha: 0.1) : AppColors.surfaceLow, borderRadius: BorderRadius.circular(99)),
            child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: status == 'Open' ? Colors.green : AppColors.onSurfaceVar)),
          ),
          IconButton(icon: const Icon(Icons.more_vert, size: 20, color: AppColors.onSurfaceVar), onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
        const SizedBox(height: 8),
        Row(children: [const Icon(Icons.business, size: 16, color: AppColors.onSurfaceVar), const SizedBox(width: 8), Text(provider, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar))]),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('AMOUNT', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
            Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text('DEADLINE', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
            Text(deadline, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error)),
          ]),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 10)), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
          const SizedBox(width: 8),
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)))),
        ]),
      ]),
    );
  }

  // ─── RIGHT SIDEBAR - Admin version ───────────────────────────────────────────

  Widget _rightSidebar(BuildContext context) {
    return Column(children: [
      _quickActions(context),
      const SizedBox(height: 32),
      _recentActivity(),
    ]);
  }

  Widget _quickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.flash_on, color: AppColors.primary), SizedBox(width: 12), Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 16),
        _quickActionBtn(Icons.add, 'Tambah Event', AppColors.primaryContainer, onTap: () => Navigator.pushNamed(context, '/admin/events')),
        const SizedBox(height: 8),
        _quickActionBtn(Icons.school, 'Tambah Beasiswa', AppColors.tertiaryContainer, onTap: () => Navigator.pushNamed(context, '/admin/scholarships')),
        const SizedBox(height: 8),
        _quickActionBtn(Icons.groups, 'Kelola Study Clubs', Colors.purple, onTap: () => Navigator.pushNamed(context, '/admin/study-clubs')),
        const SizedBox(height: 8),
        _quickActionBtn(Icons.people, 'Kelola Users', AppColors.surfaceHigh, onTap: () {}),
      ]),
    );
  }

  Widget _quickActionBtn(IconData icon, String label, Color bg, {required VoidCallback onTap}) {
    return Material(
      color: bg.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
          ]),
        ),
      ),
    );
  }

  Widget _recentActivity() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.history, color: AppColors.primary), SizedBox(width: 12), Text('Aktivitas Admin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 24),
        _activityItem(Icons.add, AppColors.primary, 'Event "Career Fair 2025" berhasil dibuat.', '5 menit lalu'),
        const SizedBox(height: 24),
        _activityItem(Icons.edit, AppColors.tertiary, 'Beasiswa Djarum diperbarui.', '1 jam lalu'),
        const SizedBox(height: 24),
        _activityItem(Icons.delete, AppColors.error, 'Event "Workshop Lama" dihapus.', 'Kemarin'),
      ]),
    );
  }

  Widget _activityItem(IconData icon, Color color, String text, String time) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(text, style: const TextStyle(fontSize: 14, color: AppColors.onSurface, height: 1.2)),
        const SizedBox(height: 4),
        Text(time, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
      ])),
    ]);
  }

  // ─── BOTTOM NAV (Mobile) ─────────────────────────────────────────────────────

  Widget _bottomNav(BuildContext context) {
    final items = [
      {'icon': Icons.dashboard, 'label': 'Dashboard', 'route': '/admin/dashboard'},
      {'icon': Icons.event, 'label': 'Events', 'route': '/admin/events'},
      {'icon': Icons.school, 'label': 'Beasiswa', 'route': '/admin/scholarships'},
      {'icon': Icons.people, 'label': 'Users', 'route': '/admin/users'},
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -4))],
        border: Border(top: BorderSide(color: AppColors.outlineVar.withValues(alpha: 0.3))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (i) => _bottomNavItem(
            context,
            items[i]['icon'] as IconData,
            items[i]['label'] as String,
            route: items[i]['route'] as String,
            active: i == _currentNavIndex,
          ))),
        ),
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, IconData icon, String label, {required String route, bool active = false}) {
    final bg = active ? AppColors.primaryContainer : Colors.transparent;
    final fg = active ? Colors.white : AppColors.onSurfaceVar;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (!active) Navigator.pushReplacementNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, color: fg)),
          ]),
        ),
      ),
    );
  }
}
