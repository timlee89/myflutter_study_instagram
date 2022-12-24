import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  void _signup() async {
    try {
      UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      // // docs의 uid를 ID 생성할 때의 uid와 동일함 (cred.user!.uid와 동일)
      // await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
      //   'username': _username.text,
      //   'uid': cred.user!.uid,
      //   'email': _email.text,
      // });

      // docs의 uid를 자동 생성하기 때문에 docs.uid field 값과는 다르다
      await FirebaseFirestore.instance.collection('users').add({
        'username': _username.text,
        'uid': cred.user!.uid,
        'email': _email.text,
      });
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
            controller: _username,
            obscureText: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter your username here',
            ),
          ),
          TextField(
            controller: _email,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress, // email 입력에 좋은 키보드 type
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true, // 안보이게 한다
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () async {
              _signup();
              Timer(const Duration(milliseconds: 500), () {
                _signin();
              });

              print("after _signup ");
              Timer(const Duration(milliseconds: 1000), () async {
                await Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              });
            },
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }
}
