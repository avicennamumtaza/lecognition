import 'package:flutter/material.dart';
import 'package:lecognition/screens/histori_screen.dart'; // Import HistoriScreen
import 'package:lecognition/screens/akun_screen.dart'; // Import AkunScreen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Profil Pengguna'),
        backgroundColor: Colors.amber, // Warna latar belakang AppBar
      ),
      body: Column(
        children: [
          // Bagian Header untuk Profil Pengguna
          Stack(
            alignment: Alignment.center, // Ini akan memusatkan elemen secara horizontal dan vertikal
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber, Color.fromARGB(255, 250, 193, 23)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 50, // Tetap mengatur posisi vertikal
                child: const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/profile_pic.jpg'), // Tambahkan gambar profil
                ),
              ),
            ],
          ),
          const SizedBox(height: 70), // Spasi antara header dan menu
          const Text(
            'Nazwa Ayunda M',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Frontend & Backend Developer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          // Menu Profile
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.account_circle,
                  title: 'Akun',
                  onTap: () {
                    // Navigasi ke halaman Akun
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AkunScreen(), // Pindah ke layar AkunScreen
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.history,
                  title: 'Histori Diagnosis',
                  onTap: () {
                    // Navigate to HistoriScreen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoriScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: 'Pengaturan',
                  onTap: () {
                    // Bisa digunakan untuk menu pengaturan
                  },
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Keluar',
                  onTap: () {
                    // Bisa digunakan untuk logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build each menu item
  Widget _buildMenuItem({required IconData icon, required String title, required Function() onTap}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: onTap,
      ),
    );
  }
}
