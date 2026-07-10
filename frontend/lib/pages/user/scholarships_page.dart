import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class ScholarshipsPage extends StatefulWidget {
  const ScholarshipsPage({super.key});

  @override
  State<ScholarshipsPage> createState() => _ScholarshipsPageState();
}

class _ScholarshipsPageState extends State<ScholarshipsPage> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Open', 'Upcoming', 'Closed'];

  final List<Map<String, String>> _scholarships = [
    {
      'title': 'Djarum Beasiswa Plus 2025/2026',
      'provider': 'Djarum Foundation',
      'amount': 'Rp 1.500.000/bulan',
      'deadline': '28 Mei 2025',
      'status': 'Open',
      'desc': 'Beasiswa prestasi untuk mahasiswa S1 minimal semester 3 dengan IPK ≥ 3.00.',
      'link': 'https://djarumbeasiswaplus.org',
    },
    {
      'title': 'Beasiswa Unggulan Kemendikbud',
      'provider': 'Kemendikbud RI',
      'amount': 'Full Tuition + Biaya Hidup',
      'deadline': '31 Agustus 2025',
      'status': 'Open',
      'desc': 'Program beasiswa pemerintah untuk putra-putri terbaik bangsa.',
      'link': 'https://beasiswaunggulan.kemdikbud.go.id',
    },
    {
      'title': 'LPDP Reguler Dalam Negeri',
      'provider': 'LPDP Kemenkeu',
      'amount': 'Full Scholarship',
      'deadline': '15 Juli 2025',
      'status': 'Upcoming',
      'desc': 'Beasiswa LPDP untuk jenjang S2/S3 di perguruan tinggi terbaik Indonesia.',
      'link': 'https://beasiswalpdp.kemenkeu.go.id',
    },
    {
      'title': 'Beasiswa BUMN Peduli',
      'provider': 'Forum BUMN',
      'amount': 'Rp 750.000/bulan',
      'deadline': '10 Maret 2025',
      'status': 'Closed',
      'desc': 'Beasiswa untuk mahasiswa kurang mampu dari seluruh Indonesia.',
      'link': 'https://forum-bumn.com',
    },
    {
      'title': 'Beasiswa Google Generation',
      'provider': 'Google LLC',
      'amount': 'USD 10.000',
      'deadline': '20 Juni 2025',
      'status': 'Open',
      'desc': 'Beasiswa internasional bagi mahasiswa yang tertarik di bidang teknologi.',
      'link': 'https://buildyourfuture.withgoogle.com/scholarships',
    },
  ];

  List<Map<String, String>> get _filtered {
    if (_selectedFilter == 'Semua') return _scholarships;
    return _scholarships.where((s) => s['status'] == _selectedFilter).toList();
  }

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
        title: const Text('Beasiswa', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
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
          // Filter chips
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
                ? const Center(child: Text('Tidak ada beasiswa untuk filter ini.', style: TextStyle(color: AppColors.onSurfaceVar)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => _scholarshipCard(_filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _scholarshipCard(Map<String, String> s) {
    final status = s['status']!;
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(99)),
                child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor)),
              ),
              IconButton(icon: const Icon(Icons.bookmark_border, color: AppColors.onSurfaceVar, size: 20), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 8),
          Text(s['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.business, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Text(s['provider']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
          ]),
          const SizedBox(height: 10),
          Text(s['desc']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar, height: 1.5)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('BENEFIT', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
                Text(s['amount']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('DEADLINE', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
                Text(s['deadline']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.error)),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: status == 'Closed'
                  ? null
                  : () async {
                      final uri = Uri.parse(s['link']!);
                      if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
                    },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: Text(status == 'Closed' ? 'Pendaftaran Ditutup' : 'Daftar Sekarang', style: const TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: status == 'Closed' ? AppColors.surfaceHigh : AppColors.primary,
                foregroundColor: status == 'Closed' ? AppColors.onSurfaceVar : Colors.white,
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
