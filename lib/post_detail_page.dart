import 'package:flutter/material.dart';
import 'package:mobile_final_project/post_page.dart';
import 'package:mobile_final_project/main.dart';

class PostDetail extends StatefulWidget {
  PostDetail(
      {required this.image, required this.title, required this.desc, Key? key})
      : super(key: key);
  final String image;
  final String title;
  final String desc;

  @override
  _PostDetailState createState() =>
      _PostDetailState(this.image, this.title, this.desc);
}

class _PostDetailState extends State<PostDetail> {
  String image;
  String title;
  String desc;
  _PostDetailState(this.image, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pushReplacement(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => MyHomePage(title: 'Login Page')));
        //       },
        //       icon: Icon(Icons.logout))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.network("$image"),
            Text(
              "$title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text("$desc", style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
