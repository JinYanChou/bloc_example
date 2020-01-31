import 'package:bloc_example/bloc/post_provider.dart';
import 'package:bloc_example/bloc/post_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'post_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PostProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text("Home Page"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _postBloc.getData();
          });
        },
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostDetail()));
                            },
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
