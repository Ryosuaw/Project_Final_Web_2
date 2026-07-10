import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudyClubsPage extends StatelessWidget {
  const StudyClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Study Clubs', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        centerTitle: true,
        backgroundColor: AppColors.surfaceLowest,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildClubCard(
            'Flutter Developer Hub', '214 Anggota',
            'Grup diskusi seputar widget, state management, dan mobile architecture.',
            Icons.phone_android, AppColors.primaryFixed,
          ),
          const SizedBox(height: 14),
          _buildClubCard(
            'UI/UX Design Masterclass', '140 Anggota',
            'Review protoype figma, kumpul aset premium, dan UI design review mingguan.',
            Icons.design_services, AppColors.tertiaryFixed,
          ),
          const SizedBox(height: 14),
          _buildClubCard(
            'Data Analytics & AI', '310 Anggota',
            'Koleksi Python notebooks, tutorial SQL, dan persiapan sertifikasi data.',
            Icons.analytics, AppColors.surfaceHigh,
          ),
        ],
      ),
    );
  }

  Widget _buildClubCard(String title, String members, String desc, IconData icon, Color iconBg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppColors.primary, size: 24)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.tertiaryContainer.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(members, style: const TextStyle(color: AppColors.tertiaryContainer, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ])),
          ]),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVar, height: 1.5)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Gabung Club', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
