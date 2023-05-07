import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foundations/screens/inner_pages/notifications_screen.dart';
import 'package:foundations/screens/login.dart';
import 'package:foundations/screens/onboarding_screen.dart';
import 'package:foundations/screens/profile/account_settings.dart';
import 'package:foundations/screens/profile/contact_info.dart';
import 'package:foundations/screens/profile/donations.dart';
import 'package:foundations/screens/profile/my_profile.dart';
import 'package:foundations/screens/profile_screen.dart';
import 'package:foundations/screens/register.dart';
import 'package:foundations/widgets/custom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
int? uid;
String? email;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  uid = prefs.getInt("uid");
  email = prefs.getString("email");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foundations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null
          ? '/onboard'
          : uid == null && email == null
              ? '/login'
              : '/home',
      routes: {
        '/home': (context) => const CustomBottomNavigation(),
        '/onboard': (context) => const Onboarding(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => const RegisterScreen(),
        '/profile': (context) => const ProfilePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/myprofile': (context) => const MyProfile(),
        '/donations': (context) => const DonationsPage(),
        '/contactInfo': (context) => const ContactInformation(),
        '/accountSettings': (context) => const AccountSettings(),
      },
      // home: Onboarding(),
    );
  }
}
