import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutter_study_instagram/utils/colors.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: Text("Setting"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${FirebaseAuth.instance.currentUser?.email}님 환영합니다"),
            const SizedBox(height: 20.0,),
            TextButton(
              child: Text("Logout"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                // Navigator.pushNamed(context, '/login');

              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 15),
                padding: EdgeInsets.all(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
