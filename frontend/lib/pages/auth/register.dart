import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D2040)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            color: Color(0xFF0D2040),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Akun Baru',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111C2D),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Bergabunglah dengan komunitas mahasiswa terbesar untuk berbagi skill dan mencari peluang belajar.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF727785),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            _buildFieldLabel('Nama Lengkap'),
            _buildTextField(Icons.person_outline, 'Contoh: Alex Noera'),
            const SizedBox(height: 16),
            _buildFieldLabel('Email'),
            _buildTextField(Icons.mail_outline, 'email@universitas.ac.id'),
            const SizedBox(height: 16),
            _buildFieldLabel('Kata Sandi'),
            _buildPasswordField(),
            const SizedBox(height: 16),
            _buildFieldLabel('Konfirmasi Kata Sandi'),
            _buildTextField(Icons.lock_reset, '••••••••', isObscure: true),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0058BE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Daftar Sekarang',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(color: Color(0xFF727785), fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0058BE),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF424754),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {bool isObscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        obscureText: isObscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF424754).withValues(alpha: 0.6), size: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF727785), fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF424754), size: 20),
          suffixIcon: Icon(Icons.visibility_outlined, color: Color(0xFF424754), size: 20),
          hintText: '••••••••',
          hintStyle: TextStyle(color: Color(0xFF727785), fontSize: 13),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }
}
