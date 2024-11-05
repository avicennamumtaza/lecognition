import 'package:flutter/material.dart';
import 'package:lecognition/presentation/profile/pages/account.dart';
import 'package:lecognition/presentation/history/pages/history.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDark = false;

  Future<void> _toggleDarkMode() async {
    try {
      setState(() {
        _isDark = !_isDark;
      });
    } catch (e) {
      print('Dark mode toggle Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     // Bagian Header untuk Profil Pengguna
    //     // Stack(
    //     //   alignment: Alignment.center, // Ini akan memusatkan elemen secara horizontal dan vertikal
    //     //   children: [
    //     //     Container(
    //     //       height: 200,
    //     //       decoration: const BoxDecoration(
    //     //         gradient: LinearGradient(
    //     //           colors: [Colors.amber, Color.fromARGB(255, 250, 193, 23)],
    //     //           begin: Alignment.topCenter,
    //     //           end: Alignment.bottomCenter,
    //     //         ),
    //     //       ),
    //     //     ),
    //     //     Positioned(
    //     //       top: 50, // Tetap mengatur posisi vertikal
    //     //       child: const CircleAvatar(
    //     //         radius: 70,
    //     //         // backgroundImage: AssetImage('assets/images/profile_pic.jpg'), // Tambahkan gambar profil
    //     //         backgroundColor: Colors.black,
    //     //       ),
    //     //     ),
    //     //   ],
    //     // ),
    //     const SizedBox(height: 70), // Spasi antara header dan menu
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: CircleAvatar(
    //         radius: 70,
    //         // backgroundImage: AssetImage('assets/images/profile_pic.jpg'), // Tambahkan gambar profil
    //         backgroundColor: Colors.black,
    //       ),
    //     ),
    //     const SizedBox(height: 30), // Spasi antara header dan menu
    //     const Text(
    //       'Nazwa Ayunda M',
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         fontSize: 22,
    //       ),
    //     ),
    //     // const SizedBox(height: 4),
    //     // const Text(
    //     //   'Frontend & Backend Developer',
    //     //   style: TextStyle(
    //     //     fontSize: 16,
    //     //     color: Colors.grey,
    //     //   ),
    //     // ),
    //     const SizedBox(height: 50),
    //     // Menu Profile
    //     Expanded(
    //       child: ListView(
    //         children: [
    //           _buildMenuItem(
    //             icon: Icons.account_circle,
    //             title: 'Akun',
    //             onTap: () {
    //               // Navigasi ke halaman Akun
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => const AkunScreen(), // Pindah ke layar AkunScreen
    //                 ),
    //               );
    //             },
    //           ),
    //           _buildMenuItem(
    //             icon: Icons.history,
    //             title: 'Histori Diagnosis',
    //             onTap: () {
    //               // Navigate to HistoriScreen when tapped
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => const HistoriScreen(),
    //                 ),
    //               );
    //             },
    //           ),
    //           _buildMenuItem(
    //             icon: _isDark? Icons.dark_mode : Icons.light_mode,
    //             title: _isDark? 'Mode Gelap' : 'Mode Terang',
    //             onTap: () {
    //               _toggleDarkMode();
    //             },
    //           ),
    //           _buildMenuItem(
    //             icon: Icons.logout,
    //             title: 'Keluar',
    //             onTap: () {
    //               // Bisa digunakan untuk logout
    //               showDialog(context: context, builder: (context) {
    //                 return AlertDialog(
    //                   title: const Text('Konfirmasi'),
    //                   content: const Text('Apakah Anda yakin ingin keluar?'),
    //                   actions: <Widget>[
    //                     TextButton(
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                       child: const Text('Batal'),
    //                     ),
    //                     TextButton(
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                       child: const Text('Keluar'),
    //                     ),
    //                   ],
    //                 );
    //               });
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 70), // Spasi antara header dan menu
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'profile_image',
            child: CircleAvatar(
              radius: 70,
              child: Image.asset(
                'assets/images/icon.png',
                width: 100,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const SizedBox(height: 30), // Spasi antara header dan menu
        const Text(
          'Nazwa Ayunda M',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        // Divider(
        //   color: Theme.of(context).colorScheme.primary,
        // ),
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
        SwitchListTile(
          value: _isDark,
          onChanged: (value) {
            _toggleDarkMode();
          },
          title: const Text('Mode Gelap', style: TextStyle(fontSize: 18)),
          secondary: Icon(
            Icons.dark_mode,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
        ),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Keluar',
          onTap: () {
            // Bisa digunakan untuk logout
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: const Text('Konfirmasi'),
                content: const Text('Apakah Anda yakin ingin keluar?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Keluar'),
                  ),
                ],
              );
            });
          },
        ),
      ],
    );
  }

  // Function to build each menu item
  Widget _buildMenuItem({required IconData icon, required String title, required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
      // minTileHeight: 50,
    );
  }
}
