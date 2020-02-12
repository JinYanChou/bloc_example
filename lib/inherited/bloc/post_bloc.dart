import 'package:http/http.dart' as http;

class PostBloc {
  final String host = "http://jsonplaceholder.typicode.com/posts";
  Map selectedPost;
  Future getData() async {
    await Future.delayed(Duration(milliseconds: 200));
    return http.get(host);
  }
}
