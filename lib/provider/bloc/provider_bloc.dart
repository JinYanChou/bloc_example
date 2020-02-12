import 'package:flutter/cupertino.dart';

class ProviderBloc with ChangeNotifier {
  final String title;
  final String body;
  int _count1 = 0;
  int _count2 = 0;

  int get count1 => _count1;
  int get count2 => _count2;

  Future get count async {
    await Future.delayed(Duration(milliseconds: 1000));
    return _count1;
  }

  void increment({int tag = 1}) {
    if (tag == 1) {
      this._count1++;
    } else {
      this._count2++;
    }
    notifyListeners();
  }

  ProviderBloc({@required this.title, @required this.body});
}