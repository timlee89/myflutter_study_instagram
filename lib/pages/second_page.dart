import 'package:flutter/material.dart';
import 'package:myflutter_study_instagram/utils/colors.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: Text("2nd screen"),
      ),
      body: Center(
        child: Text("here is 2nd screen"),
      ),
    );
  }
}
