import 'package:find_cook/core/services/share_prefs/shared_prefs_save.dart';
import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:find_cook/features/onboarding/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesClass.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   ScreenUtilInit(
        designSize: const Size(375, 812),
      child: MaterialApp(
        title: 'Flutter Demo',

        home:  StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const BasePage();
              }
              return const SplashScreen();
            })
      ),
    );
  }
}


