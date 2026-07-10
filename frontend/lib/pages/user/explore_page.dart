import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/partner_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Cari Partner', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
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
        children: const [
          Text(
            'Explore Students Match',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface),
          ),
          SizedBox(height: 6),
          Text(
            'Temukan rekan mahasiswa dari berbagai universitas untuk saling bertukar keterampilan dan berkolaborasi.',
            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVar),
          ),
          SizedBox(height: 20),
          PartnerCard(
            name: 'Sarah Azhari',
            category: 'Sistem Informasi • Universitas Indonesia',
            matchRate: 98,
            headline: 'Butuh bantuan di backend logic Flutter, bisa mengajari UI/UX Figma Design',
            skillsToTeach: ['Figma', 'UI Design', 'Wireframing'],
            skillsToLearn: ['Dart', 'Flutter', 'State Mgmt'],
            avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
          ),
          SizedBox(height: 16),
          PartnerCard(
            name: 'Budi Raharjo',
            category: 'Teknik Elektro • Institut Teknologi Bandung',
            matchRate: 85,
            headline: 'Pengen belajar data structures dasar, expert di Python & IoT hardware programming',
            skillsToTeach: ['Python', 'Internet of Things', 'Arduino'],
            skillsToLearn: ['Algorithms', 'Java', 'Dart'],
            avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
          ),
        ],
      ),
    );
  }
}
