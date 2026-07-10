import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class CompetitionsPage extends StatefulWidget {
  const CompetitionsPage({super.key});

  @override
  State<CompetitionsPage> createState() => _CompetitionsPageState();
}

class _CompetitionsPageState extends State<CompetitionsPage> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Open', 'Upcoming', 'Closed'];

  final List<Map<String, dynamic>> _competitions = [
    {
      'title': 'National UX Design Challenge 2025',
      'organizer': 'HMTI Universitas Indonesia',
      'prize': 'Total Rp 15.000.000',
      'deadline': '10 April 2025',
      'status': 'Open',
      'type': 'Design',
      'teamSize': 'Tim 2–3 orang',
      'desc': 'Kompetisi desain UI/UX nasional untuk mahasiswa aktif. Tema: Smart Campus.',
      'link': 'https://hmti.cs.ui.ac.id',
    },
    {
      'title': 'Hackathon Nasional 2025 – Kemendikbud',
      'organizer': 'Kemendikbud RI',
      'prize': 'Total Rp 50.000.000',
      'deadline': '30 Juli 2025',
      'status': 'Upcoming',
      'type': 'Coding',
      'teamSize': 'Tim 3–5 orang',
      'desc': 'Hackathon nasional untuk menciptakan solusi digital di bidang pendidikan.',
      'link': 'https://hackathon.kemdikbud.go.id',
    },
    {
      'title': 'Gemastik XVII 2025',
      'organizer': 'Belmawa Kemendikbud',
      'prize': 'Total Rp 100.000.000',
      'deadline': '25 Mei 2025',
      'status': 'Open',
      'type': 'Teknologi',
      'teamSize': 'Tim 2–4 orang',
      'desc': 'Kompetisi teknologi informasi tahunan antar perguruan tinggi se-Indonesia.',
      'link': 'https://gemastik.kemdikbud.go.id',
    },
    {
      'title': 'Business Plan Competition ITS 2025',
      'organizer': 'KPWU ITS',
      'prize': 'Total Rp 25.000.000',
      'deadline': '20 Februari 2025',
      'status': 'Closed',
      'type': 'Bisnis',
      'teamSize': 'Tim 2–3 orang',
      'desc': 'Kompetisi rencana bisnis untuk wirausaha muda mahasiswa Indonesia.',
      'link': 'https://its.ac.id',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedFilter == 'Semua') return _competitions;
    return _competitions.where((c) => c['status'] == _selectedFilter).toList();
  }

  static final _typeColors = <String, Color>{
    'Design': AppColors.tertiaryContainer,
    'Coding': AppColors.primaryContainer,
    'Teknologi': AppColors.primaryFixed,
    'Bisnis': AppColors.surfaceHigh,
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
        title: const Text('Kompetisi', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
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
                ? const Center(child: Text('Tidak ada kompetisi untuk filter ini.', style: TextStyle(color: AppColors.onSurfaceVar)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => _competitionCard(_filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _competitionCard(Map<String, dynamic> comp) {
    final status = comp['status'] as String;
    final type = comp['type'] as String;
    final typeBg = _typeColors[type] ?? AppColors.surfaceHigh;

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
              IconButton(icon: const Icon(Icons.bookmark_border, color: AppColors.onSurfaceVar, size: 20), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 10),
          Text(comp['title']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.business, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Flexible(child: Text(comp['organizer']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar))),
          ]),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.group, size: 14, color: AppColors.onSurfaceVar),
            const SizedBox(width: 6),
            Text(comp['teamSize']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar)),
          ]),
          const SizedBox(height: 10),
          Text(comp['desc']!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar, height: 1.5)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('HADIAH', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
                Text(comp['prize']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('DEADLINE', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVar)),
                Text(comp['deadline']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.error)),
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
                      final uri = Uri.parse(comp['link']!);
                      if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
                    },
              icon: const Icon(Icons.emoji_events, size: 16),
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
