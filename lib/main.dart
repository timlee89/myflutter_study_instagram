import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutter_study_instagram/backend/email_login.dart';
import 'package:myflutter_study_instagram/backend/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myflutter_study_instagram/pages/first_page.dart';
import 'package:myflutter_study_instagram/pages/second_page.dart';
import 'package:myflutter_study_instagram/pages/setting.dart';
import 'package:myflutter_study_instagram/pages/third_page.dart';
import 'package:myflutter_study_instagram/utils/colors.dart';
import 'package:myflutter_study_instagram/widgets/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jahyun Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayoutScreen(
      //   mobileScreenLayout: MobileScreenLayout(), // () 잊지 말자
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const DefaultTabController(
                length: 4,
                child: Scaffold(
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      FirstPage(),
                      SecondPage(),
                      ThirdPage(),
                      Setting(),
                    ],
                  ),
                  bottomNavigationBar: Bottom(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return const EmailLoginView();
        },
      ),

      routes: {
        '/register': (context) => const RegisterView(),
        '/emailLogin': (context) => const EmailLoginView(),
      },

    );
  }
}
