import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class Scholarship {
  int id;
  String title;
  String provider;
  String amount;
  String deadline;
  String description;
  String registrationLink;
  String status; // 'Open', 'Closed', 'Upcoming'

  Scholarship({
    required this.id,
    required this.title,
    required this.provider,
    required this.amount,
    required this.deadline,
    required this.description,
    required this.registrationLink,
    this.status = 'Open',
  });
}

class ManageScholarshipsPage extends StatefulWidget {
  const ManageScholarshipsPage({super.key});

  @override
  State<ManageScholarshipsPage> createState() => _ManageScholarshipsPageState();
}

class _ManageScholarshipsPageState extends State<ManageScholarshipsPage> {
  // Data dummy
  List<Scholarship> scholarships = [
    Scholarship(
      id: 1,
      title: 'Djarum Beasiswa Plus 2025/2026',
      provider: 'Djarum Foundation',
      amount: 'Rp 1.500.000/bulan',
      deadline: '28 Mei 2025',
      description: 'Beasiswa untuk mahasiswa S1/D4 semester 4 dengan prestasi akademik dan non-akademik.',
      registrationLink: 'https://djarumbeasiswaplus.com',
      status: 'Open',
    ),
    Scholarship(
      id: 2,
      title: 'Beasiswa Unggulan Kemendikbud',
      provider: 'Kementerian Pendidikan',
      amount: 'Full Tuition + Living Cost',
      deadline: '31 Agustus 2025',
      description: 'Beasiswa untuk mahasiswa berprestasi di seluruh Indonesia.',
      registrationLink: 'https://beasiswaunggulan.kemdikbud.go.id',
      status: 'Open',
    ),
  ];

  void _showAddEditDialog({Scholarship? scholarship}) {
    final titleController = TextEditingController(text: scholarship?.title ?? '');
    final providerController = TextEditingController(text: scholarship?.provider ?? '');
    final amountController = TextEditingController(text: scholarship?.amount ?? '');
    final deadlineController = TextEditingController(text: scholarship?.deadline ?? '');
    final descController = TextEditingController(text: scholarship?.description ?? '');
    final linkController = TextEditingController(text: scholarship?.registrationLink ?? '');
    String selectedStatus = scholarship?.status ?? 'Open';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(scholarship == null ? 'Tambah Beasiswa' : 'Edit Beasiswa'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Judul Beasiswa')),
                const SizedBox(height: 12),
                TextField(controller: providerController, decoration: const InputDecoration(labelText: 'Penyedia')),
                const SizedBox(height: 12),
                TextField(controller: amountController, decoration: const InputDecoration(labelText: 'Nominal/Manfaat')),
                const SizedBox(height: 12),
                TextField(controller: deadlineController, decoration: const InputDecoration(labelText: 'Deadline (contoh: 28 Mei 2025)')),
                const SizedBox(height: 12),
                TextField(controller: descController, decoration: const InputDecoration(labelText: 'Deskripsi'), maxLines: 3),
                const SizedBox(height: 12),
                TextField(controller: linkController, decoration: const InputDecoration(labelText: 'Link Pendaftaran (URL)')),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedStatus,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: ['Open', 'Closed', 'Upcoming']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => selectedStatus = val!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            ElevatedButton(
              onPressed: () {
                if (scholarship == null) {
                  setState(() {
                    scholarships.add(Scholarship(
                      id: scholarships.length + 1,
                      title: titleController.text,
                      provider: providerController.text,
                      amount: amountController.text,
                      deadline: deadlineController.text,
                      description: descController.text,
                      registrationLink: linkController.text,
                      status: selectedStatus,
                    ));
                  });
                } else {
                  setState(() {
                    scholarship.title = titleController.text;
                    scholarship.provider = providerController.text;
                    scholarship.amount = amountController.text;
                    scholarship.deadline = deadlineController.text;
                    scholarship.description = descController.text;
                    scholarship.registrationLink = linkController.text;
                    scholarship.status = selectedStatus;
                  });
                }
                Navigator.pop(context);
              },
              child: Text(scholarship == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteScholarship(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Beasiswa'),
        content: const Text('Yakin ingin menghapus beasiswa ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              setState(() => scholarships.removeWhere((s) => s.id == id));
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
        title: const Text('Kelola Beasiswa', style: TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.primary),
            onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
            tooltip: 'Kembali ke Dashboard',
          ),
        ],
      ),
      body: scholarships.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 64, color: AppColors.onSurfaceVar.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada beasiswa',
                    style: TextStyle(fontSize: 18, color: AppColors.onSurfaceVar),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: scholarships.length,
              itemBuilder: (context, index) {
                final s = scholarships[index];
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
                              color: s.status == 'Open'
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : AppColors.surfaceLow,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              s.status,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: s.status == 'Open' ? Colors.green : AppColors.onSurfaceVar,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: AppColors.primary, size: 20),
                                onPressed: () => _showAddEditDialog(scholarship: s),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: AppColors.error, size: 20),
                                onPressed: () => _deleteScholarship(s.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        s.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.business, size: 16, color: AppColors.onSurfaceVar),
                        const SizedBox(width: 8),
                        Text(s.provider, style: const TextStyle(fontSize: 14, color: AppColors.onSurfaceVar)),
                      ]),
                      const SizedBox(height: 12),
                      Row(children: [
                        const Icon(Icons.attach_money, size: 16, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          s.amount,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
                        ),
                      ]),
                      const SizedBox(height: 12),
                      Row(children: [
                        const Icon(Icons.calendar_month, size: 16, color: AppColors.error),
                        const SizedBox(width: 8),
                        Text(
                          'Deadline: ${s.deadline}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                      if (s.description.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(s.description, style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVar)),
                      ],
                      if (s.registrationLink.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse(s.registrationLink);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Link tidak valid')),
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.open_in_new, size: 16),
                            label: const Text(
                              'Daftar Sekarang',
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
        label: const Text('Tambah Beasiswa', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
