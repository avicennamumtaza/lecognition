import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/presentation/profile/pages/avatar.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  String? oldUsername = 'old username';
  String? oldPassword;
  String? newUsername;
  String? newPassword;
  String? confPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Edit Account'),
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
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            child: Image.asset(
                              'assets/avatars/Avatar_3.png',
                              width: 200,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              width: 35,
                              height: 35,
                              alignment: Alignment.center,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditAvatar(), // Pindah ke layar EditAccount
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: Colors.white, size: 20),
                              )
                            ),
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      oldUsername!,
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
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FormBuilderTextField(
                  name: 'username',
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'old username',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      newUsername = value;
                    });
                  },
                ),
                // decoration: InputDecoration(
                //   labelText: 'Username',
                //   hintText: 'old username',
                //   prefixIcon: Icon(Icons.person),
                //   fillColor: Colors.white,
                // ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '',
                    prefixIcon: Icon(Icons.password),
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      newPassword = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FormBuilderTextField(
                  name: 'confPassword',
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: '',
                    prefixIcon: Icon(Icons.password),
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      confPassword = value;
                    });
                  },
                ),
              ),
              // _buildInfoCard(
              //   icon: Icons.phone,
              //   title: 'Nomor Telepon',
              //   subtitle: '+6281234567890',
              // ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan aksi jika perlu
                    print('old username: $oldUsername');
                    print('new username: $newUsername');
                    print('new password: $newPassword');
                    print('confirmasi password: $confPassword');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // icon: const Icon(Icons.save_alt),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}