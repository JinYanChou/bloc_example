import 'package:bloc_example/inherited/bloc/post_provider.dart';
import 'package:bloc_example/inherited/post_home.dart';
import 'package:bloc_example/provider/bloc/provider_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/provider_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.green.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text(
                  "Bloc Inherited Widget",
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PostProvider(child: PostHomePage())));
                }),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
                child: Text(
                  "Provider",
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                      ChangeNotifierProvider(
                        create: (context) => ProviderBloc(title: "Top10", body: "Content"),
                        child: ProviderHome(),
                      )
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
