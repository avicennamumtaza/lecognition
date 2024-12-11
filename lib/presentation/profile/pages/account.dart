import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/presentation/profile/bloc/user_cubit.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:lecognition/presentation/profile/pages/edit.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Akun Saya'),
      body: BlocProvider(
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
              return SingleChildScrollView(
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
                                  'assets/avatars/Avatar_${state.user.avatar}.png',
                                  width: 200,
                                ),
                                backgroundColor: Colors.transparent,
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
                        subtitle: state.user.username!,
                        context: context,
                      ),
                      _buildInfoCard(
                        icon: Icons.email,
                        title: 'Email',
                        subtitle: state.user.email!,
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
                                builder: (context) => EditAccount(
                                  userData: state.user,
                                ),
                              ),
                            ).then((_) {
                              context.read<UserCubit>().getUserProfile();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
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
              );
            }
            return Container();
          },
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
        leading:
            Icon(icon, color: Colors.black.withOpacity(0.7), size: 30),
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
