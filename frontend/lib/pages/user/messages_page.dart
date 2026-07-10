import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Pesan Masuk', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
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
          _buildChatItem(context, 'Sarah Azhari', "Awesome! I look forward to it. See you tomorrow at 2 PM!", '10:33 AM', true),
          const Divider(color: AppColors.surfaceLow),
          _buildChatItem(context, 'Budi Raharjo', 'Boleh tanya soal setup virtual environment Python?', 'Kemarin', false),
          const Divider(color: AppColors.surfaceLow),
          _buildChatItem(context, 'Andi Setyawan', 'Halo Kak, makasih infonya ya!', '3 hari lalu', false),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String name, String lastMsg, String time, bool isUnread) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: isUnread ? AppColors.primaryContainer : AppColors.surfaceLow,
        child: Icon(Icons.person, color: isUnread ? Colors.white : AppColors.onSurfaceVar),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isUnread ? AppColors.onSurface : AppColors.onSurfaceVar)),
      subtitle: Text(lastMsg, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.onSurfaceVar, fontSize: 12)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(color: AppColors.onSurfaceVar, fontSize: 10)),
          const SizedBox(height: 4),
          if (isUnread)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/chat');
      },
    );
  }
}
