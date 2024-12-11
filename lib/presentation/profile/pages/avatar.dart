import 'package:flutter/material.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/data/user/models/update_user_profile_params.dart';
import 'package:lecognition/domain/user/entities/user.dart';
import 'package:lecognition/domain/user/usecases/update_user_profile.dart';
import 'package:lecognition/service_locator.dart';

class EditAvatar extends StatefulWidget {
  final UserEntity userData;
  const EditAvatar({super.key, required this.userData});

  @override
  _EditAvatarState createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  late int avatarChoosen;

  @override
  void initState() {
    super.initState();
    avatarChoosen = widget.userData.avatar!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Ubah Avatar'),
      body: SingleChildScrollView(
        child: Column(
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
                        'assets/avatars/Avatar_${avatarChoosen}.png',
                        width: 200,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Text(
                    widget.userData.username!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        print("AVATAR CHOSEN $avatarChoosen");
                        final result =
                            await sl<UpdateUserProfileUseCase>().call(
                          params: UpdateUserProfileParams(
                            userAvatar: avatarChoosen,
                            email: widget.userData.email!,
                            username: widget.userData.username!,
                            password: widget.userData.password!,
                          ),
                        );
                        print("RESULTTTTTTT $result");
                        result.fold(
                          (failure) {
                            DisplayMessage.errorMessage(
                              context,
                              failure.toString(),
                            );
                          },
                          (success) {
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              count++;
                              return count == 3;
                            });
                            DisplayMessage.errorMessage(
                              context,
                              success.toString(),
                            );
                          },
                        );
                      } catch (error) {
                        DisplayMessage.errorMessage(context, error.toString());
                      }
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Menampilkan avatar dalam 3 baris, 2 avatar per baris
            for (int i = 1; i <= 6; i += 2)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _avatarItem(i, context),
                    _avatarItem(i + 1, context),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _avatarItem(int avatarId, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          avatarChoosen = avatarId;
          print(avatarChoosen);
        });
      },
      child: Image.asset(
        'assets/avatars/Avatar_$avatarId.png',
        width: 100,
        height: 100,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(
            color: avatarId == avatarChoosen
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        backgroundColor: avatarId == avatarChoosen
            ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
            : Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
