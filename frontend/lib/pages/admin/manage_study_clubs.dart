import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class StudyClub {
  int id;
  String name;
  String category;
  String description;
  String mentorName;
  String schedule;
  String googleFormLink;
  String whatsappGroupLink;
  int memberCount;
  int maxMembers;
  String status; // 'Open', 'Closed', 'Full'

  StudyClub({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.mentorName,
    required this.schedule,
    required this.googleFormLink,
    this.whatsappGroupLink = '',
    this.memberCount = 0,
    this.maxMembers = 30,
    this.status = 'Open',
  });
}

class ManageStudyClubsPage extends StatefulWidget {
  const ManageStudyClubsPage({super.key});

  @override
  State<ManageStudyClubsPage> createState() => _ManageStudyClubsPageState();
}

class _ManageStudyClubsPageState extends State<ManageStudyClubsPage> {
  List<StudyClub> clubs = [
    StudyClub(
      id: 1,
      name: 'Flutter Development Club',
      category: 'Programming',
      description: 'Belajar Flutter dari dasar hingga mahir. Cocok untuk yang ingin membuat aplikasi mobile.',
      mentorName: 'Ahmad Rizki (TI 2021)',
      schedule: 'Setiap Sabtu, 14:00 - 16:00',
      googleFormLink: 'https://forms.gle/example1',
      memberCount: 24,
      maxMembers: 30,
      status: 'Open',
    ),
    StudyClub(
      id: 2,
      name: 'UI/UX Design Club',
      category: 'Design',
      description: 'Pelajari prinsip desain UI/UX, Figma, dan user research.',
      mentorName: 'Siti Nurhaliza (DKV 2020)',
      schedule: 'Setiap Rabu, 16:00 - 18:00',
      googleFormLink: 'https://forms.gle/example2',
      memberCount: 30,
      maxMembers: 30,
      status: 'Full',
    ),
  ];

  void _showAddEditDialog({StudyClub? club}) {
    final nameController = TextEditingController(text: club?.name ?? '');
    final categoryController = TextEditingController(text: club?.category ?? '');
    final descController = TextEditingController(text: club?.description ?? '');
    final mentorController = TextEditingController(text: club?.mentorName ?? '');
    final scheduleController = TextEditingController(text: club?.schedule ?? '');
    final gformController = TextEditingController(text: club?.googleFormLink ?? '');
    final waController = TextEditingController(text: club?.whatsappGroupLink ?? '');
    final maxMembersController = TextEditingController(text: club?.maxMembers.toString() ?? '30');
    String selectedStatus = club?.status ?? 'Open';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(club == null ? 'Tambah Study Club' : 'Edit Study Club'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Club'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Kategori (contoh: Programming, Design, Business)'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: mentorController,
                  decoration: const InputDecoration(labelText: 'Nama Mentor'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: scheduleController,
                  decoration: const InputDecoration(labelText: 'Jadwal (contoh: Setiap Sabtu, 14:00 - 16:00)'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: gformController,
                  decoration: const InputDecoration(labelText: 'Link Google Form Pendaftaran'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: waController,
                  decoration: const InputDecoration(labelText: 'Link WhatsApp Group (opsional)'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: maxMembersController,
                  decoration: const InputDecoration(labelText: 'Kuota Maksimal Anggota'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedStatus,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: ['Open', 'Closed', 'Full']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => selectedStatus = val!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (club == null) {
                  setState(() {
                    clubs.add(StudyClub(
                      id: clubs.length + 1,
                      name: nameController.text,
                      category: categoryController.text,
                      description: descController.text,
                      mentorName: mentorController.text,
                      schedule: scheduleController.text,
                      googleFormLink: gformController.text,
                      whatsappGroupLink: waController.text,
                      maxMembers: int.tryParse(maxMembersController.text) ?? 30,
                      status: selectedStatus,
                    ));
                  });
                } else {
                  setState(() {
                    club.name = nameController.text;
                    club.category = categoryController.text;
                    club.description = descController.text;
                    club.mentorName = mentorController.text;
                    club.schedule = scheduleController.text;
                    club.googleFormLink = gformController.text;
                    club.whatsappGroupLink = waController.text;
                    club.maxMembers = int.tryParse(maxMembersController.text) ?? 30;
                    club.status = selectedStatus;
                  });
                }
                Navigator.pop(context);
              },
              child: Text(club == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteClub(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Study Club'),
        content: const Text('Yakin ingin menghapus club ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              setState(() => clubs.removeWhere((c) => c.id == id));
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
          onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
        ),
        title: const Text('Kelola Study Clubs', style: TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.primary),
            onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
            tooltip: 'Kembali ke Dashboard',
          ),
        ],
      ),
      body: clubs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.groups, size: 64, color: AppColors.onSurfaceVar.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada study club',
                    style: TextStyle(fontSize: 18, color: AppColors.onSurfaceVar),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final c = clubs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.4)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: c.status == 'Open'
                                  ? AppColors.primaryContainer
                                  : (c.status == 'Full'
                                      ? AppColors.error.withValues(alpha: 0.1)
                                      : AppColors.surfaceLow),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              c.status,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: c.status == 'Open'
                                    ? Colors.white
                                    : (c.status == 'Full' ? AppColors.error : AppColors.onSurfaceVar),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: AppColors.primary, size: 20),
                                onPressed: () => _showAddEditDialog(club: c),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: AppColors.error, size: 20),
                                onPressed: () => _deleteClub(c.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        c.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          c.category,
                          style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVar),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(c.description,
                          style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVar)),
                      const SizedBox(height: 16),
                      Row(children: [
                        const Icon(Icons.person, size: 16, color: AppColors.onSurfaceVar),
                        const SizedBox(width: 8),
                        Text(
                          'Mentor: ${c.mentorName}',
                          style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVar),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.schedule, size: 16, color: AppColors.onSurfaceVar),
                        const SizedBox(width: 8),
                        Text(c.schedule,
                            style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVar)),
                      ]),
                      const SizedBox(height: 12),
                      Row(children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: c.memberCount >= c.maxMembers ? AppColors.error : AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${c.memberCount}/${c.maxMembers} Anggota',
                          style: TextStyle(
                            fontSize: 13,
                            color: c.memberCount >= c.maxMembers
                                ? AppColors.error
                                : AppColors.onSurfaceVar,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: c.googleFormLink.isNotEmpty
                              ? () async {
                                  final uri = Uri.parse(c.googleFormLink);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.edit_note, size: 16),
                          label: const Text(
                            'Daftar via Google Form',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      if (c.whatsappGroupLink.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse(c.whatsappGroupLink);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              }
                            },
                            icon: const Icon(Icons.chat, size: 16),
                            label: const Text(
                              'WhatsApp Group',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Tambah Study Club', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
