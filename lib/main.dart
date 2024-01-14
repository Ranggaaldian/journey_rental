import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journeyrental/firebase_options.dart';
import 'package:journeyrental/ui/pages/detail_page.dart';
import 'package:journeyrental/ui/pages/history_page.dart';
import 'package:journeyrental/ui/pages/home_page.dart';
import 'package:journeyrental/ui/pages/checkout_page.dart';
import 'package:journeyrental/ui/pages/login_page.dart';
import 'package:journeyrental/ui/pages/register_page.dart';
import 'package:journeyrental/ui/pages/profil_page.dart';
import 'package:journeyrental/ui/pages/splash_page.dart';
import 'package:journeyrental/ui/screen/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'J-rent',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      // ? Mendefinisikan rute dalam aplikasi
      routes: {
        '/splash':(context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
        '/detail': (context) => const DetailPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/history': (context) => const HistoryPage(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
