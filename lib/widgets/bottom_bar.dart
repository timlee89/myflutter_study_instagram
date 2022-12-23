import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        height: 80,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(
              icon: Icon(Icons.home, size: 25,),
              child: Text('Home', style: TextStyle(fontSize: 10),),
            ),
            Tab(
              icon: Icon(Icons.search, size: 25,),
              child: Text('2nd', style: TextStyle(fontSize:10),),
            ),
            Tab(
              icon: Icon(Icons.download, size: 25,),
              child: Text('3rd', style: TextStyle(fontSize: 10),),
            ),
            Tab(
              icon: Icon(Icons.settings, size: 25,),
              child: Text('4th', style: TextStyle(fontSize: 10),),
            ),
          ],
        ),
      ),
    );
  }
}