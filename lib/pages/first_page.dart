import 'package:flutter/material.dart';
import 'package:myflutter_study_instagram/utils/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: Text("1st screen"),
      ),
      body: Center(
        child: Text("here is 1st screen"),
      ),
    );
  }
}
