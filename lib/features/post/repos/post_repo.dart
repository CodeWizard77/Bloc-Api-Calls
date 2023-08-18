import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class PostRepo {
  // Get Api Logic
  static Future<List<PostModel>> fetchApi() async {
    var client = http.Client();
    List<PostModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/"));

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostModel model = PostModel.fromJson(result[i] as Map<String, dynamic>);
        posts.add(model);
      }
      return posts;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  // Post Api Logic :-
  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: {
          "title": "Sample Text",
          "body": "This is Sample Text",
          "userId": "35",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
