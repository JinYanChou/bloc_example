import 'package:bloc_example/provider/bloc/provider_bloc.dart';
import 'package:bloc_example/provider/provider_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderBloc bloc = Provider.of<ProviderBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.center,
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Consumer<ProviderBloc>(
//                          builder: (context, ProviderBloc bloc, child) {
//                        return Text(
//                          "${bloc.title} / ${bloc.body} / ${bloc.count1}",
//                          style: TextStyle(fontSize: 40),
//                        );
//                      }),
//                      SizedBox(
//                        height: 20,
//                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                          Consumer(
//                            builder: (context, ProviderBloc bloc, widget) {
//                              print("do consumer");
//                              return Container(
//                                  color: Colors.green.shade200,
//                                  child: Text("${bloc.count1.toString()}", style: TextStyle(fontSize: 30),));
//                            },
//                          ),
//                          SizedBox(
//                            width: 20,
//                          ),
                          Selector(
                            builder: (BuildContext context, int count,
                                Widget child) {
                              print("do Selector 1");
                              return Container(
                                color: Colors.purple.shade200,
                                child: Text(
                                  "Selector Count 1 => ${count.toString()}",
                                  style: TextStyle(fontSize: 30),
                                ),
                              );
                            },
                            selector:
                                (BuildContext context, ProviderBloc bloc) {
                              return bloc.count1;
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Selector(
                            builder: (BuildContext context, int count,
                                Widget child) {
                              print("do Selector 2");
                              return Container(
                                color: Colors.brown.shade200,
                                child: Text(
                                  "Selector Count 2 => ${count.toString()}",
                                  style: TextStyle(fontSize: 30),
                                ),
                              );
                            },
                            selector:
                                (BuildContext context, ProviderBloc bloc) {
                              return bloc.count2;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Change1"),
                            onPressed: () {
                              bloc.increment(tag: 1);
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                            child: Text("Change2"),
                            onPressed: () {
                              bloc.increment(tag: 2);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        child: Text("Next"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProviderDetail()));
                        },
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  color: Colors.blue,
                  child: Text("Back"),
                  onPressed: () {
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
