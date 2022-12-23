import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutter_study2/src/pages/home.dart';

class EmailLoginView extends StatefulWidget {
  const EmailLoginView({Key? key}) : super(key: key);

  @override
  State<EmailLoginView> createState() => _EmailLoginViewState();
}

class _EmailLoginViewState extends State<EmailLoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;


  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              TextInputType.emailAddress, // email 입력에 좋은 키보드 type
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Enter your email here',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true, // 안보이게 한다
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


class ddd extends StatefulWidget {
  const ddd({Key? key}) : super(key: key);

  @override
  State<ddd> createState() => _dddState();
}

class _dddState extends State<ddd> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
