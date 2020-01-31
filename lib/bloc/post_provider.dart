import 'package:flutter/material.dart';
import 'post_bloc.dart';

class PostProvider extends InheritedWidget {

  final PostBloc postBloc = PostBloc();

  PostProvider({Key key, Widget child}):super(key: key, child: child);

  static PostBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PostProvider>().postBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

}