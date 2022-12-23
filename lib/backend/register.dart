import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  void _signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      // await FirebaseAuth.instance.signInWithCredential(UserCredential);
      print("after _signup: ");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void _signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      print("after logged in: ");

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
        title: const Text('Register with Email'),
      ),
      //** FutureBuilder로 firebase initialize하고,  */
      body: Column(
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
          TextButton(
            child: const Text('Register', style: TextStyle(fontSize: 18),),
            onPressed: () async {
              _signup();
              // Timer(Duration(milliseconds: 500), () {
              //   _signin();
              // });

              print("after _signup ");
              // Timer(Duration(milliseconds: 1000), () async {
              //   await Navigator.of(context).pushNamedAndRemoveUntil('/app', (route) => false);
              // });


            },
          ),
          const SizedBox(width: 20.0,),



        ],
      ),
    );
  }
}


