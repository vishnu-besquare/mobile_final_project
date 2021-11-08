import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:mobile_final_project/main.dart';

class AddPost extends StatefulWidget {
  AddPost({required this.postchannel, Key? key}) : super(key: key);
  IOWebSocketChannel postchannel;
  // final controllerImage=TextEditingController();
  // final controllerTitle=TextEditingController();
  // final controllerDesc= TextEditingController();

  @override
  _AddPostState createState() => _AddPostState(this.postchannel);
}

class _AddPostState extends State<AddPost> {
  IOWebSocketChannel postchannel;
  _AddPostState(this.postchannel);
  final controllerImage = TextEditingController();
  final controllerTitle = TextEditingController();
  final controllerDesc = TextEditingController();

  void Addpost() {
    postchannel.sink.add(
        '{"type": "create_post","data": {"title": "${controllerTitle.text}","description": "${controllerDesc.text}","image": "${controllerImage.text}"}}');
    print('${controllerTitle.text} upload is a success');

    controllerImage.clear();
    controllerTitle.clear();
    controllerDesc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        actions: [
          IconButton(
              onPressed: () {
                postchannel.sink.close();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Login Page')));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image URl',
              ),
              controller: controllerImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              controller: controllerTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              controller: controllerDesc,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text('Create Post'),
                  onPressed: () {
                    Addpost();
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text('Cancel'),
                  onPressed: () {
                    controllerImage.clear();
                    controllerTitle.clear();
                    controllerDesc.clear();
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
