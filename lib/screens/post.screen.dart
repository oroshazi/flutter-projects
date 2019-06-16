import 'package:flutter/material.dart';
import 'package:tutorial_infinite_list/model/post.model.dart';

class PostScreen extends StatelessWidget {
  Post post = Post();

  PostScreen({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Column(
        children: <Widget>[
          Text(post.title),
          Card(
            child: Text(post.body),
          ),
          Text(post.id.toString()),
        ],
      ),
    );
  }
}
