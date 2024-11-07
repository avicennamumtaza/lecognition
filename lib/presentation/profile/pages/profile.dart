import 'package:flutter/material.dart';
import 'package:lecognition/presentation/auth/pages/signin.dart';
import 'package:lecognition/presentation/profile/pages/account.dart';
import 'package:lecognition/presentation/history/pages/history.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/presentation/profile/bloc/user_cubit.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:lecognition/presentation/profile/pages/account.dart';
import 'package:lecognition/presentation/history/pages/history.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserCubit()..getUserProfile(),
//       child: BlocBuilder<UserCubit, UserState>(
//         builder: (context, state) {
//           if (state is UserLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is UserFailureLoad) {
//             return Center(
//               child: Text(state.errorMessage),
//             );
//           }
//           if (state is UserLoaded) {
//             return ListView(
//               children: [
//                 const SizedBox(height: 70),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Hero(
//                     tag: 'profile_image',
//                     child: CircleAvatar(
//                       radius: 70,
//                       child: Image.asset(
//                         'assets/images/icon.png',
//                         width: 100,
//                       ),
//                       backgroundColor: Theme.of(context).colorScheme.secondary,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Text(
//                   state.user.username!,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   state.user.email!,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 15,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 50),
//                 // Divider(
//                 //   color: Theme.of(context).colorScheme.primary,
//                 // ),
//                 // Menambahkan Divider sebagai garis bawah
//                 Container(
//                   height: 20,
//                   child: Divider(
//                     color: Colors.grey, // Warna garis bawah
//                     thickness: 1.0, // Ketebalan garis
//                     height: 1.0, // Jarak vertikal garis
//                   ),
//                 ),
//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.account_circle,
//                   title: 'Akun',
//                   onTap: () {
//                     // Navigasi ke halaman Akun
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             const AkunScreen(), // Pindah ke layar AkunScreen
//                       ),
//                     );
//                   },
//                 ),
//                 // Menambahkan Divider sebagai garis bawah
//                 Container(
//                   height: 20,
//                   child: Divider(
//                     color: Colors.grey, // Warna garis bawah
//                     thickness: 1.0, // Ketebalan garis
//                     height: 1.0, // Jarak vertikal garis
//                   ),
//                 ),
//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.history,
//                   title: 'Histori Diagnosis',
//                   onTap: () {
//                     // Navigate to HistoriScreen when tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HistoriScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 // Menambahkan Divider sebagai garis bawah
//                 Container(
//                   height: 20,
//                   child: Divider(
//                     color: Colors.grey, // Warna garis bawah
//                     thickness: 1.0, // Ketebalan garis
//                     height: 1.0, // Jarak vertikal garis
//                   ),
//                 ),
//                 SwitchListTile(
//                   value: false,
//                   onChanged: (value) {
//                     value = !value;
//                   },
//                   title:
//                       const Text('Mode Gelap', style: TextStyle(fontSize: 18)),
//                   secondary: Icon(
//                     Icons.dark_mode,
//                     size: 30,
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                   activeColor: Theme.of(context).colorScheme.primary,
//                   inactiveThumbColor: Colors.grey,
//                   inactiveTrackColor: Colors.grey.shade300,
//                 ),
//                 // Menambahkan Divider sebagai garis bawah
//                 Container(
//                   height: 20,
//                   child: Divider(
//                     color: Colors.grey, // Warna garis bawah
//                     thickness: 1.0, // Ketebalan garis
//                     height: 1.0, // Jarak vertikal garis
//                   ),
//                 ),
//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.logout,
//                   title: 'Keluar',
//                   onTap: () {
//                     // Bisa digunakan untuk logout
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Konfirmasi'),
//                           content:
//                               const Text('Apakah Anda yakin ingin keluar?'),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const Text('Batal'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const Text('Keluar'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 // Menambahkan Divider sebagai garis bawah
//                 Container(
//                   height: 20,
//                   child: Divider(
//                     color: Colors.grey, // Warna garis bawah
//                     thickness: 1.0, // Ketebalan garis
//                     height: 1.0, // Jarak vertikal garis
//                   ),
//                 ),
//               ],
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }

//   // Function to build each menu item
//   Widget _buildMenuItem(
//       {required IconData icon,
//       required String title,
//       required Function() onTap,
//       required BuildContext context}) {
//     return ListTile(
//       leading:
//           Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
//       title: Text(title, style: const TextStyle(fontSize: 18)),
//       onTap: onTap,
//       // minTileHeight: 50,
//     );
//   }
// }

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
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 70), // Spasi antara header dan menu
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'profile_image',
            child: CircleAvatar(
              radius: 100,
              child: Image.asset(
                'assets/avatars/Avatar_3.png',
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninPage()
                          )
                      );
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
