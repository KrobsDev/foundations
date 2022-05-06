import 'package:flutter/material.dart';

import '../constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: const Padding(
      //     padding: EdgeInsets.only(left: 20, right: 8),
      //     child: CircleAvatar(
      //       backgroundImage: NetworkImage(
      //         "https://images.unsplash.com/photo-1573496358961-3c82861ab8f4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGhlYWRzaG90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
      //       ),
      //     ),
      //   ),
      //   title: const Image(image: AssetImage('assets/logo/logo-dark-sm.png')),
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.only(right: 20),
      //       child: Icon(
      //         Icons.notifications_none_outlined,
      //         color: kDefaultBackground,
      //         size: 30,
      //       ),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(),
                  child: const Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/abstract_bg2.png',
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -70,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1573496358961-3c82861ab8f4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGhlYWRzaG90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -90,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        // color: Colors.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          // border: Border.all(),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: inactiveColor.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: kDefaultBackground,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 100.0, bottom: 2),
              child: Center(
                child: Text(
                  'Vanessa Moriwa',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Text(
              'vmoriwa@gmail.com',
              style: TextStyle(color: inactiveColor),
            ),
            const SizedBox(height: 20),
            ListTile(
              minLeadingWidth: 10,
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: const Icon(Icons.account_balance_wallet_rounded),
              title: const Text('Donations'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: const Icon(Icons.person),
              title: const Text('Notification'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: const Icon(Icons.contact_phone),
              title: const Text('Contact Information'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              minLeadingWidth: 10,
              leading: const Icon(Icons.settings),
              title: const Text('Account Settings'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
