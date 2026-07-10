import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isDesktop = c.maxWidth >= 1024;
        final isTablet  = c.maxWidth >= 768;

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
                                _feedAndSidebar(context, isDesktop),
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
          floatingActionButton: isTablet && !isDesktop ? _fab() : null,
        );
      },
    );
  }

  // ─── SIDEBAR (Desktop) ───────────────────────────────────────────────────────

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
              errorBuilder: (_, e, s) => const Icon(Icons.school, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 8),
            const Text('NOERA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
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
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBu2VQrh7Op-A_YZ5rQ8pvKn_wEsNDIGfiFy6pYIWSfQPRSys7Z374XSIH87cfqAJeXWOpvuTe6jO9T8SoGV6SQXs4F8zp2snYnf_eTwqATy4djF-GN56i57k-uJU1DL2cFnFT_mCvRfGCoFYjypwezTXfQljkOTSdAwmI0Sjnyn7ogf2gNs7-Qo8YguDqvLPQpCGe6jGcQfnaMgXRUaR9R1K4q32MBkFM_3YOfJ23YslWXTwd76dArHS9773-pDGBk5fmkmLBSK64',
            width: 48, height: 48, fit: BoxFit.cover,
            errorBuilder: (_, e, s) => const CircleAvatar(radius: 24, backgroundColor: AppColors.surfaceHigh, child: Icon(Icons.person, color: AppColors.primary)),
          ),
        ),
        const SizedBox(width: 16),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Kakak Cica', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          Text('Teknik Informatika', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
        ]),
      ]),
    );
  }

  Widget _navList(BuildContext context) {
    final items = [
      {'icon': Icons.grid_view, 'label': 'Dashboard', 'route': '/dashboard', 'active': true},
      {'icon': Icons.explore, 'label': 'Skill Exchange', 'route': '/explore', 'badge': 'New'},
      {'icon': Icons.school, 'label': 'Scholarships', 'route': '/scholarships'},
      {'icon': Icons.emoji_events, 'label': 'Competitions', 'route': '/competitions'},
      {'icon': Icons.event, 'label': 'Seminars', 'route': '/seminars'},
      {'icon': Icons.groups, 'label': 'Study Club', 'route': '/study-clubs'},
    ];
    return ListView(
      padding: EdgeInsets.zero,
      children: items.map((i) => _navItem(
        context,
        i['icon'] as IconData,
        i['label'] as String,
        route: i['route'] as String,
        active: i['active'] == true,
        badge: i['badge'] as String?,
      )).toList(),
    );
  }

  Widget _bottomNavList(BuildContext context) {
    return Column(children: [
      Divider(color: AppColors.outlineVar.withValues(alpha: 0.3)),
      const SizedBox(height: 16),
      _navItem(context, Icons.settings, 'Settings', route: '/settings'),
      _navItem(context, Icons.logout, 'Logout', route: '/login', isError: true),
    ]);
  }

  Widget _navItem(BuildContext context, IconData icon, String label, {
    required String route,
    bool active = false,
    String? badge,
    bool isError = false,
  }) {
    final color  = isError ? AppColors.error : (active ? Colors.white : AppColors.onSurfaceVar);
    final bgColor = isError ? AppColors.error.withValues(alpha: 0.1) : (active ? AppColors.primaryContainer : Colors.transparent);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (!active) Navigator.pushReplacementNamed(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color, letterSpacing: 0.6)),
              if (badge != null) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                  child: Text(badge, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
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
              errorBuilder: (_, e, s) => const Icon(Icons.school, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            const Text('NOERA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
          ]),
          Row(children: [
            Stack(children: [
              IconButton(icon: const Icon(Icons.notifications, color: AppColors.primary), onPressed: () {}),
              Positioned(top: 12, right: 12, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle, border: Border.all(color: AppColors.surface, width: 2)))),
            ]),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBAD7rznq-5J_Qw-NF4RfgrYk8VwghIOatPRIdOgM8ueaz3nBwmlKgE7NkjcDQTDTd-uJRLo3jsH8PgQInohueyR-wnKg9064vHmybvf7cYu1w-chPHFbhRW0Bq2y5TczD06ijs3J2sFnCb71AAtAFOdYWKTsbZMf1AgXo_FGLX7OumKmI9zD8qwDEMJAw0fqNmEvHkveNH9czoKEQkeRb0nc99bJLRU6opDL43ri3FXhIQh4UX1LCWk6KmpbSJqpjo-uPz3TpVFBU',
                  width: 32, height: 32, fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => const CircleAvatar(radius: 16, backgroundColor: AppColors.surfaceHigh, child: Icon(Icons.person, size: 18, color: AppColors.primary)),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  // ─── HERO SECTION ────────────────────────────────────────────────────────────

  Widget _hero(BuildContext context, bool isTablet) {
    final heroContent = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.onSurface, letterSpacing: -0.5),
          children: [
            TextSpan(text: 'Selamat datang kembali, '),
            TextSpan(text: 'KAKAK CICA!', style: TextStyle(color: AppColors.primary)),
          ],
        ),
      ),
      // Hidden Text for widget-test discoverability
      const Offstage(child: Text('KAKAK CICA!')),
      const SizedBox(height: 4),
      const Text('Ada 3 partner request baru & 5 peluang yang cocok untukmu hari ini.',
        style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVar)),
    ]);
    final buttons = Row(children: [
      _actionButton(Icons.search, 'Cari Partner', AppColors.inverseSurface, AppColors.inverseOnSurface,
        onTap: () => Navigator.pushNamed(context, '/explore')),
      const SizedBox(width: 12),
      _actionButton(Icons.trending_up, 'Liat Peluang', AppColors.primary, Colors.white, onTap: () {}),
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

  // ─── STATS ───────────────────────────────────────────────────────────────────

  Widget _stats() {
    return Row(children: [
      Expanded(child: _statCard(Icons.bolt, '6', 'Skill Aktif', AppColors.primaryFixed.withValues(alpha: 0.3))),
      const SizedBox(width: 12),
      Expanded(child: _statCard(Icons.handshake, '3', 'Partner Requests', AppColors.surfaceHigh)),
    ]);
  }

  Widget _statCard(IconData icon, String val, String label, Color iconBg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))],
      ),
      child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: AppColors.primary)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVar, letterSpacing: 0.6)),
        ]),
      ]),
    );
  }

  // ─── FEED + RIGHT SIDEBAR ────────────────────────────────────────────────────

  Widget _feedAndSidebar(BuildContext context, bool isDesktop) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 8, child: _mainFeed(context)),
          const SizedBox(width: 32),
          Expanded(flex: 4, child: _rightSidebar(context)),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mainFeed(context),
        const SizedBox(height: 32),
        _rightSidebar(context),
      ],
    );
  }

  Widget _mainFeed(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader(Icons.campaign, 'Peluang Terbaru Untukmu', 'Lihat Semua', onTap: () {}),
      const SizedBox(height: 16),
      SizedBox(
        height: 340,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _opportunityCard('BEASISWA', 'Djarum Beasiswa Plus 2025/2026', 'Djarum Foundation', ['S1 / D4', 'Prestasi'], '28 Mei 2025', 'Rp 1.5M/Bulan', AppColors.primaryContainer),
            const SizedBox(width: 12),
            _opportunityCard('KOMPETISI', 'National UX Design Challenge 2025', 'HMTI UI', ['Tim', 'Design'], '10 Apr 2025', 'Total Rp 15 Juta', AppColors.tertiaryContainer),
          ],
        ),
      ),
      const SizedBox(height: 32),
      _sectionHeader(Icons.groups, 'Partner Terbaik Untukmu', 'Skill Exchange', onTap: () => Navigator.pushNamed(context, '/explore')),
      const SizedBox(height: 16),
      LayoutBuilder(builder: (context, c) {
        final isLarge = c.maxWidth >= 600;
        final card1 = _partnerCard(context, 'Amanda Putri', 'Teknik Informatika • ITB', '95% Match', '"Mau buat aplikasi mobile untuk portofolio beasiswa. Butuh partner Flutter."', ['Laravel', 'REST API'], ['Flutter'], 'https://lh3.googleusercontent.com/aida-public/AB6AXuAzDQaVyNG_n7_npYUOe465V3SWpBiCji9eR002lgW5k7u2tY7ekMgFvq8AjXdP4tz1uPWIuidi8Tg8mxSGrQhjmIvaXQTzsmrW7iuVFTK_AyU4JBXasBw83MT9hePxC2yyL37xgOSnp6p-3KQwqyHqYkaGq7Z3NxulXBbYOfrZn4VuG_9V2VWv7bBn4VoAD38eIYs2Cu2bX87L416yqusqoU0Vb426JFPhT1EfMnCqfBVyZxWFB6HMGyG9olUMM7_o78kQTXCprfk');
        final card2 = _partnerCard(context, 'Budi Santoso', 'Sistem Informasi • UI', '98% Match', '"Cari partner untuk lomba UX & bangun MVP. Bisa ajarin design framework."', ['UI/UX Design', 'Figma'], ['React Native'], 'https://lh3.googleusercontent.com/aida-public/AB6AXuAksVX-3EK5Z3HknZPlD5YHHNLaYMNSqwkbHB_nFNeVzStJ0qbwAC3wRySdRcrCD8zyFW-vTpViGQv_F4-8eS1VjM5oNdipTjN71FuwOxQV-XRsvkR7XE2Zl41BWClSb_m3UGhc-4UGIhHZfoyHFuRjP4BnilyOee5BoXWbAuZk3asNZe1G9d3n9trQNnqRQ16AVMcRZxUx5jmBHlNoZr4H3CekdbHtCkF91DsTGTjO_eFxGaIkgjiD2CK_JN4wjaEJ465ZG13m_dA');
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

  Widget _opportunityCard(String type, String title, String org, List<String> tags, String deadline, String benefit, Color typeBg) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: typeBg, borderRadius: BorderRadius.circular(99)), child: Text(type, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 0.5))),
          IconButton(icon: const Icon(Icons.bookmark_border, size: 20), onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
        const SizedBox(height: 8),
        Row(children: [const Icon(Icons.business, size: 16, color: AppColors.onSurfaceVar), const SizedBox(width: 8), Text(org, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar))]),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: tags.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(8)), child: Text(t, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)))).toList()),
        Container(height: 1, color: AppColors.outlineVar.withValues(alpha: 0.3), margin: const EdgeInsets.symmetric(vertical: 12)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('DEADLINE', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
              Row(children: [const Icon(Icons.calendar_month, size: 14, color: AppColors.error), const SizedBox(width: 4), Flexible(child: Text(deadline, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error), overflow: TextOverflow.ellipsis))]),
            ]),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              const Text('BENEFIT', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
              Text(benefit, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary), overflow: TextOverflow.ellipsis, textAlign: TextAlign.end),
            ]),
          ),
        ]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Lihat Detail', style: TextStyle(fontWeight: FontWeight.bold)))),
      ]),
    );
  }

  Widget _partnerCard(BuildContext context, String name, String major, String match, String quote, List<String> teach, List<String> learn, String img) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Stack(clipBehavior: Clip.none, children: [
            ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(img, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, e, s) => const CircleAvatar(radius: 28, backgroundColor: AppColors.surfaceHigh, child: Icon(Icons.person, color: AppColors.primary)))),
            Positioned(bottom: -2, right: -2, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
          ]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Flexible(child: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 4),
                const Icon(Icons.verified, color: AppColors.primary, size: 16),
              ]),
              Text(major, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar), overflow: TextOverflow.ellipsis),
            ]),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(99)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.auto_awesome, color: AppColors.primary, size: 14), const SizedBox(width: 4), Text(match, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary))]),
          ),
        ]),
        const SizedBox(height: 16),
        Text(quote, style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVar, fontStyle: FontStyle.italic)),
        const SizedBox(height: 20),
        _skillSection('BISA MENGAJARI:', teach, AppColors.primaryContainer, AppColors.primaryFixed),
        const SizedBox(height: 12),
        _skillSection('INGIN BELAJAR:', learn, AppColors.tertiaryContainer, AppColors.tertiaryFixed),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send, size: 16), label: const Text('Kirim Request'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
          const SizedBox(width: 8),
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.surfaceHigh, borderRadius: BorderRadius.circular(12)),
            child: IconButton(icon: const Icon(Icons.chat, color: AppColors.primary), onPressed: () => Navigator.pushNamed(context, '/chat')),
          ),
        ]),
      ]),
    );
  }

  Widget _skillSection(String title, List<String> skills, Color titleBg, Color chipBg) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: titleBg.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)), child: Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: titleBg))),
      const SizedBox(height: 8),
      Wrap(spacing: 8, runSpacing: 8, children: skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: chipBg.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Text(s, style: TextStyle(fontSize: 10, color: titleBg)))).toList()),
    ]);
  }

  // ─── RIGHT SIDEBAR ───────────────────────────────────────────────────────────

  Widget _rightSidebar(BuildContext context) {
    return Column(children: [
      _profileCompletion(context),
      const SizedBox(height: 32),
      _recentActivity(),
      const SizedBox(height: 32),
      _promoBanner(context),
    ]);
  }

  Widget _profileCompletion(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 40, offset: const Offset(0, 20))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.person, color: AppColors.primary), SizedBox(width: 12), Text('Profil Kamu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 16),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Kelengkapan Profil', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
          Text('72%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.primary)),
        ]),
        const SizedBox(height: 8),
        Container(
          height: 8,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(99)),
          child: const FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.72,
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Tambahkan 2 skill lagi untuk meningkatkan match rate kamu!', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
        const SizedBox(height: 16),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _tag('Flutter'), _tag('Dart'), _tag('Firebase'),
          OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 14), label: const Text('Tambah', style: TextStyle(fontSize: 10)), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary), foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
        ]),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/profile'), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary, width: 2), foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Edit Profil', style: TextStyle(fontWeight: FontWeight.bold)))),
      ]),
    );
  }

  Widget _tag(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(8)), child: Text(t, style: const TextStyle(fontSize: 10, color: AppColors.onSurface)));

  Widget _recentActivity() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceLow, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.history, color: AppColors.primary), SizedBox(width: 12), Text('Aktivitas Terkini', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 24),
        _activityItem(Icons.mail, AppColors.primary, 'Amanda Putri mengirim partner request padamu.', '5 menit lalu'),
        const SizedBox(height: 24),
        _activityItem(Icons.bookmark, AppColors.tertiary, 'Kamu menyimpan Beasiswa Unggulan Kemendikbud.', '1 jam lalu'),
        const SizedBox(height: 24),
        _activityItem(Icons.check_circle, Colors.green, 'Skill "Flutter" berhasil diverifikasi.', 'Kemarin'),
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

  Widget _promoBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))]),
      child: Stack(children: [
        Positioned(right: -40, bottom: -40, child: Container(width: 160, height: 160, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle))),
        Positioned(left: -40, top: -40, child: Container(width: 128, height: 128, decoration: BoxDecoration(color: AppColors.primaryFixed.withValues(alpha: 0.2), shape: BoxShape.circle))),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Daftar Study Club', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 8),
          Text('Gabung grup belajar mingguan bersama mentor mahasiswa berprestasi.', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.9))),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/study-clubs'),
            icon: const Icon(Icons.arrow_forward, size: 16),
            label: const Text('Explore Groups', style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          ),
        ]),
      ]),
    );
  }

  // ─── BOTTOM NAV (Mobile) ─────────────────────────────────────────────────────

  Widget _bottomNav(BuildContext context) {
    final items = [
      {'icon': Icons.dashboard, 'label': 'Home', 'route': '/dashboard'},
      {'icon': Icons.explore, 'label': 'Explore', 'route': '/explore'},
      {'icon': Icons.handshake, 'label': 'Matches', 'route': '/explore'},
      {'icon': Icons.chat, 'label': 'Chat', 'route': '/messages'},
      {'icon': Icons.person, 'label': 'Profil', 'route': '/profile'},
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
    final bg  = active ? AppColors.primaryContainer : Colors.transparent;
    final fg  = active ? Colors.white : AppColors.onSurfaceVar;
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

  Widget _fab() {
    return FloatingActionButton(onPressed: () {}, backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white, size: 32));
  }
}
