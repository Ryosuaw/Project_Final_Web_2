import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../theme/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  late AnimationController _typingController;

  // --- PALETTE COLORS (Mapped from Tailwind Config) ---
  final Color bg = const Color(0xFFFAFAF9);
  final Color surface = const Color(0xFFFFF8F5);
  final Color surfaceContainer = const Color(0xFFF4ECE8);
  final Color surfaceContainerLow = const Color(0xFFFAF2EE);
  final Color surfaceContainerLowest = Colors.white;
  final Color onSurface = const Color(0xFF1E1B19);
  final Color onSurfaceVariant = const Color(0xFF424754);
  final Color outline = const Color(0xFF727785);
  final Color outlineVariant = const Color(0xFFC2C6D6);
  final Color primary = AppColors.primary;
  final Color tertiary = const Color(0xFF006947);

  @override
  void initState() {
    super.initState();
    // Animasi untuk indikator "sedang mengetik"
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    
    // Auto scroll ke bawah saat halaman pertama kali dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDateSeparator(),
                    const SizedBox(height: 24),
                    _buildReceivedMessage("Hi there! I saw your request for the UI Design skill exchange. I'd love to help you with Figma components!", "10:24 AM"),
                    const SizedBox(height: 24),
                    _buildSentMessage("That sounds amazing, Sarah! I've been struggling with auto-layout nesting. When are you free for a quick session?", "10:26 AM"),
                    const SizedBox(height: 24),
                    _buildReceivedMessage("I can do tomorrow at 2 PM. I can share some of my design system templates with you as well.", "10:28 AM"),
                    const SizedBox(height: 24),
                    _buildSentMessage("Perfect. 2 PM works for me! I'll prepare my current project to show you where I'm stuck.", "10:30 AM"),
                    const SizedBox(height: 24),
                    _buildTypingIndicator(),
                  ],
                ),
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: surface,
        border: Border(bottom: BorderSide(color: outlineVariant)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: primary),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/messages');
                },
              ),
              const SizedBox(width: 12),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBERBDQz-HuqM2B7BAr_5-O1kjXx2gXNnKESiQB78zHxJo9IFg9SSu-I3DokWFEkZOUW-pf6TYATehR1NrLscCbqGO0PTfEG-Z2L7Ekc93CulRhgouXZSNPYjw6oxQ7Il8POxHl-RoSIPEaQ0h7CVNfokDOv47g1G8VN8oICfXMf_H3yh-HHTZ4Lfih66njFKz_5ZonaFvExLv7hETpvT2Y5MoMwYjx8rTLmcdlbH0ih0ReNug5XTAUzNIyeM29oIiqVJkCdRrL_SM',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, e, s) => const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.surfaceHigh,
                        child: Icon(Icons.person, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: tertiary,
                        shape: BoxShape.circle,
                        border: Border.all(color: surface, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sarah Mitchell",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: onSurface),
                  ),
                  Text(
                    "Expert UI Designer",
                    style: TextStyle(fontSize: 10, color: onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.more_vert, color: onSurfaceVariant),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: surfaceContainer,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          "TODAY",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: outlineVariant),
            ),
            child: Text(text, style: TextStyle(fontSize: 14, color: onSurface, height: 1.4)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 4.0),
            child: Text(time, style: TextStyle(fontSize: 10, color: outline)),
          ),
        ],
      ),
    );
  }

  Widget _buildSentMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.zero,
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.white, height: 1.4)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0, top: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(time, style: TextStyle(fontSize: 10, color: outline)),
                const SizedBox(width: 4),
                Icon(Icons.done_all, size: 12, color: primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0),
        const SizedBox(width: 4),
        _buildDot(1),
        const SizedBox(width: 4),
        _buildDot(2),
        const SizedBox(width: 8),
        Text(
          "Sarah is typing...",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: onSurfaceVariant.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _typingController,
      builder: (context, child) {
        double delay = index * 0.2;
        double t = (_typingController.value + delay) % 1.0;
        double y = -3 * math.sin(t * math.pi); // Efek pantulan ke atas dan bawah
        return Transform.translate(
          offset: Offset(0, y),
          child: child,
        );
      },
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: outline,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: surface,
        border: Border(top: BorderSide(color: outlineVariant)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              decoration: BoxDecoration(
                color: surfaceContainerLowest,
                border: Border.all(color: outline),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(color: onSurfaceVariant.withValues(alpha: 0.5)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          setState(() => _textController.clear());
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined, color: onSurfaceVariant),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_textController.text.trim().isNotEmpty) {
                  setState(() => _textController.clear());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
