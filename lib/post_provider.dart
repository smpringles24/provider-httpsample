import 'package:flutter/material.dart';
import 'post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsProvider with ChangeNotifier {
  static String postUrl = 'https://jsonplaceholder.typicode.com/posts';

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<List<Post>> fetchAndSetPosts() async {
    final response = await http.get(Uri.parse(postUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      _posts = body.map((dynamic item) => Post.fromJson(item)).toList();
      notifyListeners();
      return _posts;
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}
