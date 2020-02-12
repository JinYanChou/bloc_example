import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_example/inherited/bloc/post_provider.dart';
import 'package:bloc_example/inherited/bloc/post_bloc.dart';
import 'package:flutter/services.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  PostBloc _postBloc;
  String title = "";
  String body = "";

  @override
  void initState() {
    print('init state');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _postBloc = PostProvider.of(context);
    print('post_detail didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('widget build');
    _postBloc = PostProvider.of(context);
    if (_postBloc.selectedPost != null) {
      title = _postBloc.selectedPost["title"];
      body = _postBloc.selectedPost["body"];
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 30, 50, 30),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Post Detail"),
            automaticallyImplyLeading: false,
          ),
          body: _PostDetailBody(title: title, body: body)),
    );
  }
}

class _PostDetailBody extends StatelessWidget {
  final String title;
  final String body;

  _PostDetailBody({@required this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                minSize: 10,
                color: Colors.blue,
                child: Text("Test"),
                onPressed: () async {
                  final MethodChannel _channel = MethodChannel('com.example.bloc_example/alert');
                  var result = await _channel.invokeMethod("show", {"TITLE": "ABC"});
                  print("method channel => ${result}");
                },
              ),
              SizedBox(
                width: 10,
              ),
              CupertinoButton(
                minSize: 10,
                color: Colors.blue,
                child: Text("Back"),
                onPressed: () {
                  var dialog = CupertinoAlertDialog(
                    content: Text("返回前一頁"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "取消",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "確認",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                  showCupertinoDialog(
                      context: context, builder: (context) => dialog);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
