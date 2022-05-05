import 'package:flutter/material.dart';
import 'package:foundations/screens/onboarding_screen.dart';
import 'package:foundations/widgets/custom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(const MyApp());
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
      initialRoute: initScreen == 0 || initScreen == null ? '/onboard' : '/',
      routes: {
        '/': (context) => const CustomBottomNavigation(),
        '/onboard': (context) => const Onboarding(),
      },
      // home: Onboarding(),
    );
  }
}
