import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/provider_bloc.dart';

abstract class MyTextStyle {
  static TextStyle titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold
  );

  static TextStyle bodyStyle = TextStyle(
      fontSize: 30,
  );
}

class ProviderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProviderDetail(),
    );
  }
}

class _ProviderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Title: ", style: MyTextStyle.titleStyle,),
            Consumer<ProviderBloc>(
              builder: (context, ProviderBloc bloc, child) {
                return Text("${bloc.title}", style: MyTextStyle.bodyStyle,);
              },
            )
          ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Body: ", style: MyTextStyle.titleStyle,),
            Consumer<ProviderBloc>(
              builder: (context, ProviderBloc bloc, child) {
                return Text("${bloc.body}", style: MyTextStyle.bodyStyle,);
              },
            )
          ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Count: ", style: MyTextStyle.titleStyle,),
            Consumer<ProviderBloc>(
              builder: (context, ProviderBloc bloc, child) {
                return Text("${bloc.count1}", style: MyTextStyle.bodyStyle,);
              },
            )
          ],
        ),
        SizedBox(height: 30,),
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            child: Text("Back"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
