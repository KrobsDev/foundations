import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  // String? email = '';

  // void _checkLoggedIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var obtainedEmail = prefs.getString('email');
  //   setState(() {
  //     email = obtainedEmail;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () =>
            Navigator.of(context, rootNavigator: true).pushNamed('/profile'),
        child: const Padding(
          padding: EdgeInsets.only(left: 20, right: 8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1573496358961-3c82861ab8f4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGhlYWRzaG90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
            ),
          ),
        ),
      ),
      title: const Image(image: AssetImage('assets/logo/logo-dark-sm.png')),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/notifications');
            },
            child: const Icon(
              Icons.notifications_none_outlined,
              color: kDefaultBackground,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
