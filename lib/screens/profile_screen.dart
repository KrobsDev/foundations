import 'dart:convert';
import 'package:foundations/widgets/loading_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foundations/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../env.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? uid;

  bool isLoading = false;

  // function check if user is logged in
  Future _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("uid");
    });

    // print(uid);
  }

  // User object to use throughout page
  User? user;

  // get user details
  Future _getUserDetails() async {
    var url = Uri.parse("${Env.URL_PREFIX_USERS}/read_single.php?id=$uid");
    var response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    var res = jsonDecode(response.body);

    // get user in user object
    Map<String, dynamic> userMap = res;
    User userObj = User.fromJson(userMap);

    // print(user.email);
    setState(() {
      user = userObj;
    });

    // print(user!.email);
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('uid');
    prefs.remove('fname');
    prefs.remove('lname');

    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoggedIn().whenComplete(() {
      _getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingScreen()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          extendBodyBehindAppBar: true,
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 2),
                  child: Center(
                    child: Text(
                      user == null
                          ? '...loading'
                          : user!.fname! + ' ' + user!.lname!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text(
                  user == null ? '...loading' : user!.email!,
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
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/myprofile');
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(Icons.account_balance_wallet_rounded),
                  title: const Text('Donations'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/donations');
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(Icons.contact_phone),
                  title: const Text('Contact Information'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/contactInfo');
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(Icons.settings),
                  title: const Text('Account Settings'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/accountSettings');
                  },
                ),
                ListTile(
                  minLeadingWidth: 10,
                  leading: const Icon(Icons.logout),
                  title: Text(
                    uid != null ? 'Logout' : 'Login',
                  ),
                  // onTap: () {
                  //   uid != null ? Navigator.of(context, rootNavigator: true).pushNamed('/login') : ;
                  // },
                  onTap: () {
                    uid != null
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                  'Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    setState(() {
                                      isLoading = true;
                                    });

                                    await Future.delayed(
                                      const Duration(seconds: 3),
                                    );

                                    _logout();

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: const Text('Logout'),
                                )
                              ],
                            ),
                          )
                        : Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', ((route) => false));
                  },

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
}
