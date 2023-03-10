import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutter_study_instagram/backend/auth_methods.dart';
import 'package:myflutter_study_instagram/utils/colors.dart';

class EmailLoginView extends StatefulWidget {
  const EmailLoginView({Key? key}) : super(key: key);

  @override
  State<EmailLoginView> createState() => _EmailLoginViewState();
}

class _EmailLoginViewState extends State<EmailLoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late bool _isLoading;


  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  void _signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      print("after _signin ; logged in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // void _loginUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String res = await AuthMethods().loginUser(
  //       email: _email.text, password: _password.text);
  //   if (res == 'success') {
  //     Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print("LoginUser Result is...");
  //     print(res);
  //     // showSnackBar(context, res);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: Text("Email Login"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType:
              TextInputType.emailAddress, // email ????????? ?????? ????????? type
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Enter your email here',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true, // ???????????? ??????
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintText: 'Enter your password here',
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     _signup();
            //     _signin();
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Register', style: TextStyle(fontSize: 18),),
            // ),
            const SizedBox(width: 20.0,),
            TextButton(
              child: const Text('Log in', style: TextStyle(fontSize: 18),),
              onPressed: () async {
                // await AuthMethods().loginUser(
                //     email:_email.text, password:_password.text
                // );
                _signin();
              },
            ),
            const SizedBox(height: 50.0,),
            TextButton(
              child: const Text('Not registered yet? Register here'),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),


          ],
        ),
      ),
    );

  }
}

