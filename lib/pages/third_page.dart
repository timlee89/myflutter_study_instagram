import 'package:flutter/material.dart';
import 'package:myflutter_study_instagram/utils/colors.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor2,
        title: Text("3rd screen"),
      ),
      body: Center(
        child: Text("here is 3rd screen"),
      ),
    );
  }
}
