import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_final_project/about_page.dart';
import 'package:mobile_final_project/add_post_page.dart';
import 'package:mobile_final_project/post_detail_page.dart';
import 'dart:io';
import 'package:mobile_final_project/main.dart';

import 'package:web_socket_channel/io.dart';

// final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
List post = [];

class PostPage extends StatefulWidget {
  PostPage({required this.postchannel, Key? key}) : super(key: key);
  IOWebSocketChannel postchannel;

  @override
  State<PostPage> createState() => _PostPageState(this.postchannel);
}

class _PostPageState extends State<PostPage> {
  IOWebSocketChannel postchannel;
  _PostPageState(this.postchannel);
  void getPost() {
    postchannel.stream.listen((posting) {
      final decodedMessage = jsonDecode(posting);

      setState(() {
        post = decodedMessage['data']['posts'];
      });
      print(post);
      // postchannel.sink.close();
    });

    postchannel.sink.add('{"type": "get_posts"}');
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  bool iconbtn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posting Page'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border_sharp)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
              icon: Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddPost(postchannel: postchannel)));
              },
              icon: Icon(Icons.add)),
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
        child: Column(
          children: [
            Container(
              child: post.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: post.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetail(
                                          image: post[index]['image'],
                                          title: post[index]['title'],
                                          desc: post[index]['description'])));
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 15, bottom: 8, top: 8),
                                    child: SizedBox(
                                        width: 100,
                                        height: 150,
                                        child: Image.network(
                                          post[index]['image'],
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Image.network(
                                                "https://image.shutterstock.com/image-vector/vector-stop-sign-icon-no-260nw-1077922790.jpg");
                                          },
                                        )),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Row(
                                            children: [
                                              Text(post[index]['title']),
                                              SizedBox(width: 8),
                                              // Text(post[index]['last_name'])
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            post[index]['description'],
                                            maxLines: 3,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                              post[index]['author'] ?? " "),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(post[index]['date']))
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
