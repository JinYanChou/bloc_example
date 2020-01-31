import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_example/bloc/post_provider.dart';
import 'package:bloc_example/bloc/post_bloc.dart';

class PostDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostBloc _postBloc = PostProvider.of(context);
    String title = _postBloc.selectedPost["title"];
    String body = _postBloc.selectedPost["body"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Detail"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Title：",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(child: Text(title))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Body：",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(body),
                      )
                    ],
                  ),
                ],
              ),
            ),
            CupertinoButton(
              minSize: 10,
              color: Colors.blue,
              child: Text("Back"),
              onPressed: () {
                var dialog = CupertinoAlertDialog(
                  content: Text("測試訊息"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "確認",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
                showCupertinoDialog(
                    context: context, builder: (context) => dialog);
                //Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
