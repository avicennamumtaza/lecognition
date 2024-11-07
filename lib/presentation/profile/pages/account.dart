import 'package:flutter/material.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/presentation/profile/pages/edit.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Akun Saya'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: 'profile_image',
                      child: CircleAvatar(
                        radius: 100,
                        child: Image.asset(
                          'assets/avatars/Avatar_3.png',
                          width: 200,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Nazwa Ayunda M',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      // 'Frontend & Backend Developer',
                      '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Bagian informasi akun
              const Text(
                'Informasi Akun',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.person,
                title: 'Username',
                subtitle: 'Nazwa Ayunda M',
                context: context,
              ),
              _buildInfoCard(
                icon: Icons.email,
                title: 'Email',
                subtitle: 'nazwam@example.com',
                context: context,
              ),
              // _buildInfoCard(
              //   icon: Icons.phone,
              //   title: 'Nomor Telepon',
              //   subtitle: '+6281234567890',
              // ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan aksi jika perlu
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAccount(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    'Edit Akun',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi akun dalam bentuk Card
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      shadowColor: Colors.grey,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
