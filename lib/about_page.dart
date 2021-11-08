import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_final_project/main.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => MyHomePage(title: 'Login Page')));
        //       },
        //       icon: Icon(Icons.logout))
        // ],
      ),
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('About Us',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
                "This page is regarding the who we are and what we do as a company. This company was built as a results of the hardwork by youngsters.Their hardword and time is well appreciated."),
          )
        ],
      )),
    );
  }
}
