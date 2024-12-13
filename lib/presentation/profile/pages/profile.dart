import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/presentation/auth/pages/signin.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/pages/bookmarked.dart';
import 'package:lecognition/presentation/profile/pages/account.dart';
import 'package:lecognition/presentation/history/pages/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/presentation/profile/bloc/user_cubit.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:provider/provider.dart';
import '../../../core/configs/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDark = false;


  @override
  void initState() {
    super.initState();
    _isDark = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUserProfile(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserFailureLoad) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is UserLoaded) {
            return ListView(
              children: [
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: 'profile_image',
                    child: CircleAvatar(
                      radius: 100,
                      child: Image.asset(
                        'assets/avatars/Avatar_${state.user.avatar}.png',
                        fit: BoxFit.cover,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  state.user.username!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                _buildMenuItem(
                  context: context,
                  icon: Icons.account_circle,
                  title: 'Akun',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AkunScreen(),
                      ),
                    ).then(
                      (value) => BlocProvider.of<UserCubit>(context).getUserProfile(),
                    );
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.history,
                  title: 'Riwayat Diagnosis',
                  onTap: () {
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
                    setState(() {
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      _isDark = value;
                    });
                    print(value);
                  },
                  title:
                      const Text('Mode Gelap', style: TextStyle(fontSize: 18)),
                  secondary: Icon(
                    Icons.dark_mode,
                    size: 30,
                  ),
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade300,
                  activeTrackColor: Colors.grey.shade300,
                ),
                _buildMenuItem(
                  icon: Icons.bookmark,
                  title: "Penyakit Tersimpan",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookmarkedScreen(),
                      ),
                    ).then((_) {
                      BlocProvider.of<BookmarkCubit>(context).getAllBookmarkedDiseases();
                    });
                  },
                  context: context,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.logout,
                  title: 'Keluar',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Konfirmasi', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                          content: const Text('Apakah anda yakin ingin keluar?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Batal', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                            ),
                            TextButton(
                              onPressed: () {
                                final storage = const FlutterSecureStorage();
                                storage.delete(key: 'access_token');
                                storage.delete(key: 'refresh');
                                print('Delete Token');
                                AppNavigator.pushReplacement(
                                  context,
                                  SigninPage(),
                                );
                              },
                              child: Text('Keluar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  // Function to build each menu item
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Function() onTap,
    required BuildContext context
  }) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }
}
