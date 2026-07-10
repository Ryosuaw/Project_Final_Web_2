import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class SeminarsPage extends StatefulWidget {
  const SeminarsPage({super.key});

  @override
  State<SeminarsPage> createState() => _SeminarsPageState();
}

class _SeminarsPageState extends State<SeminarsPage> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Open', 'Upcoming', 'Selesai'];

  final List<Map<String, dynamic>> _seminars = [
    {
      'title': 'AI & Machine Learning Workshop 2025',
      'organizer': 'HMTI Universitas Brawijaya',
      'date': '20 Juli 2025',
      'time': '09.00 – 16.00 WIB',
      'location': 'Lab Komputer Gedung F, UB',
      'status': 'Open',
      'type': 'Workshop',
      'price': 'Gratis',
      'quota': '150 peserta',
      'desc': 'Workshop intensif pemrograman machine learning menggunakan Python dan TensorFlow.',
      'link': 'https://hmti.ub.ac.id',
    },
    {
      'title': 'Seminar Nasional Teknologi 2025',
      'organizer': 'Fasilkom UI',
      'date': '5 Agustus 2025',
      'time': '08.00 – 17.00 WIB',
      'location': 'Auditorium UI, Depok',
      'status': 'Upcoming',
      'type': 'Seminar',
      'price': 'Rp 50.000',
      'quota': '500 peserta',
      'desc': 'Seminar nasional dengan pembicara dari Google, Gojek, dan Tokopedia.',
      'link': 'https://fasilkom.ui.ac.id',
    },
    {
      'title': 'Flutter Advanced Development Bootcamp',
      'organizer': 'Google Developer Group',
      'date': '12 Juli 2025',
      'time': '10.00 – 17.00 WIB',
      'location': 'Online (Zoom)',
      'status': 'Open',
      'type': 'Bootcamp',
      'price': 'Gratis',
      'quota': '200 peserta',
      'desc': 'Belajar Flutter advanced: state management, Firebase, dan deployment ke Play Store.',
      'link': 'https://gdg.community.dev',
    },
    {
      'title': 'Webinar Startup & Entrepreneurship',
      'organizer': 'Inkubator Bisnis ITS',
      'date': '15 Maret 2025',
      'time': '13.00 – 15.00 WIB',
      'location': 'Online (YouTube Live)',
      'status': 'Selesai',
      'type': 'Webinar',
      'price': 'Gratis',
      'quota': 'Unlimited',
      'desc': 'Berbagi pengalaman membangun startup dari founder startup unicorn Indonesia.',
      'link': 'https://its.ac.id/inkubator',
    },
    {
      'title': 'Design Thinking for Innovation',
      'organizer': 'Creative Hub Indonesia',
      'date': '1 September 2025',
      'time': '09.00 – 12.00 WIB',
      'location': 'Jakarta Convention Center',
      'status': 'Upcoming',
      'type': 'Workshop',
      'price': 'Rp 75.000',
      'quota': '80 peserta',
      'desc': 'Pelajari metodologi design thinking untuk memecahkan masalah secara kreatif.',
      'link': 'https://creativehub.id',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedFilter == 'Semua') return _seminars;
    return _seminars.where((s) => s['status'] == _selectedFilter).toList();
  }

  static final _typeColors = <String, Color>{
    'Workshop': AppColors.primaryContainer,
    'Seminar': AppColors.tertiaryContainer,
    'Bootcamp': AppColors.primaryFixed,
    'Webinar': AppColors.surfaceHigh,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        title: const Text('Seminar & Workshop', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.primary),
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            tooltip: 'Beranda',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((f) {
                  final active = _selectedFilter == f;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f),
                      selected: active,
                      onSelected: (_) => setState(() => _selectedFilter = f),
                      selectedColor: AppColors.primaryContainer,
                      backgroundColor: AppColors.surfaceLow,
                      labelStyle: TextStyle(
                        color: active ? Colors.white : AppColors.onSurfaceVar,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('Tidak ada acara untuk filter ini.', style: TextStyle(color: AppColors.onSurfaceVar)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => _seminarCard(_filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _seminarCard(Map<String, dynamic> s) {
    final status = s['status'] as String;
    final type = s['type'] as String;
    final typeBg = _typeColors[type] ?? AppColors.surfaceHigh;
    final isFree = s['price'] == 'Gratis';
    final isDone = status == 'Selesai';

    final Color statusColor = status == 'Open'
        ? Colors.green
        : status == 'Upcoming'
            ? AppColors.primary
            : AppColors.onSurfaceVar;
    final Color statusBg = status == 'Open'
        ? Colors.green.withValues(alpha: 0.1)
        : status == 'Upcoming'
            ? AppColors.primaryFixed
            : AppColors.surfaceLow;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: typeBg, borderRadius: BorderRadius.circular(99)),
                  child: Text(type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(99)),
                  child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor)),
                ),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isFree ? Colors.green.withValues(alpha: 0.1) : AppColors.primaryFixed,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  isFree ? 'GRATIS' : s['price']!,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isFree ? Colors.green : AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(s['title']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.business, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Flexible(child: Text(s['organizer']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar))),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.calendar_today, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Text('${s['date']}  •  ${s['time']}', style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.location_on, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Flexible(child: Text(s['location']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar))),
          ]),
          const SizedBox(height: 10),
          Text(s['desc']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar, height: 1.5)),
          const SizedBox(height: 10),
          Row(children: [
            const Icon(Icons.people, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Text('Kuota: ${s['quota']}', style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
          ]),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isDone
                  ? null
                  : () async {
                      final uri = Uri.parse(s['link']!);
                      if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
                    },
              icon: Icon(isDone ? Icons.check_circle : Icons.event_available, size: 16),
              label: Text(isDone ? 'Acara Telah Selesai' : 'Daftar Sekarang', style: const TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDone ? AppColors.surfaceHigh : AppColors.primary,
                foregroundColor: isDone ? AppColors.onSurfaceVar : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
