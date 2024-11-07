import 'package:flutter/material.dart';
import 'package:lecognition/common/widgets/appbar.dart';

class EditAvatar extends StatelessWidget {
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
                        'assets/avatars/Avatar_3.png',
                        width: 200,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Simpan', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
            for (int i = 1; i <= 6; i += 2)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _avatarItem('Avatar $i', 'assets/avatars/Avatar_$i.png', context),
                    _avatarItem('Avatar ${i + 1}', 'assets/avatars/Avatar_${i + 1}.png', context),
                  ],
                ),
              ),
          ],
        )
      ),
    );
  }

  Widget _avatarItem(String avatarName, String imagePath, BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Image.asset(
        imagePath,
        width: 120,
        height: 100,
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}