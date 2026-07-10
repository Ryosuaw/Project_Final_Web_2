import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  final List<Map<String, String>> _events = [
    {'title': 'Workshop Flutter Lanjutan', 'date': '15 Jul 2025', 'type': 'Workshop', 'status': 'Aktif'},
    {'title': 'Seminar AI & Machine Learning', 'date': '22 Jul 2025', 'type': 'Seminar', 'status': 'Aktif'},
    {'title': 'Kompetisi Hackathon Nasional', 'date': '30 Jul 2025', 'type': 'Kompetisi', 'status': 'Draft'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Kelola Event', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        centerTitle: true,
        backgroundColor: AppColors.surfaceLowest,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Tambah Event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _events.length,
        separatorBuilder: (_, i) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final event = _events[index];
          final isActive = event['status'] == 'Aktif';
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVar.withValues(alpha: 0.3)),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Row(children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppColors.primaryFixed, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.event, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(event['title']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.calendar_today, size: 12, color: AppColors.onSurfaceVar),
                  const SizedBox(width: 4),
                  Text(event['date']!, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVar)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green.withValues(alpha: 0.1) : AppColors.surfaceLow,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(event['status']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? Colors.green : AppColors.onSurfaceVar)),
                  ),
                ]),
              ])),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: AppColors.onSurfaceVar),
                onSelected: (value) {
                  if (value == 'delete') {
                    setState(() => _events.removeAt(index));
                  }
                },
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 16), SizedBox(width: 8), Text('Edit')])),
                  const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 16, color: AppColors.error), SizedBox(width: 8), Text('Hapus', style: TextStyle(color: AppColors.error))])),
                ],
              ),
            ]),
          );
        },
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Event Baru'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(decoration: InputDecoration(labelText: 'Judul Event', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Tanggal', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Tipe Event', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _events.add({'title': 'Event Baru', 'date': '01 Aug 2025', 'type': 'Workshop', 'status': 'Draft'});
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
