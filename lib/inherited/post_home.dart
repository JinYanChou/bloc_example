import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'post_detail.dart';
import 'bloc/post_bloc.dart';
import 'bloc/post_provider.dart';

class PostHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  PostBloc _postBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postBloc = PostProvider.of(context);
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inherited Widget"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _postBloc.getData();
          });
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.green.shade50,
              child: FutureBuilder(
                  initialData: [],
                  future: _postBloc.getData(),
                  builder: (context, snap) {
                    switch (snap.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: CupertinoActivityIndicator());
                      case ConnectionState.done:
                        if (snap.hasError) print('Error: ${snap.error}');
                        if (!snap.hasData) {
                          return Center(child: Text("No Data"));
                        }
                        break;
                    }
                    List datas = jsonDecode(snap.data.body);
                    return ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (context, idx) {
                          var data = datas[idx];
                          return ListTile(
                            title: Text(data["title"]),
                            subtitle: Text(data["body"]),
                            dense: false,
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              _postBloc.selectedPost = data;
                              showDialog(barrierDismissible: false,
                                  context: context,
                                  useRootNavigator: false,
                                  builder: (_) => PostDetail());
                            },
                          );
                        });
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  color: Colors.blue,
                  child: Text("Back"),
                  onPressed: (){
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
