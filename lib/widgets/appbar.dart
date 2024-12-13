import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({
    super.key,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        // style: TextStyle(
        //   color:  Theme.of(context).colorScheme.onPrimary,
        // ),
      ),
      // backgroundColor: Theme.of(context).colorScheme.primary,
      // foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}