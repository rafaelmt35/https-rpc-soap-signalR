import 'dart:convert';

import 'package:catapi_test/catClass.dart';
import 'package:http/http.dart' as http;
import 'package:catapi_test/postClass.dart';

class RemoteService {
  //GET FUNCTION
  Future<Post> getPost() async {
    var client = http.Client();

    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await client.get(
      url,
    );
    print('Response status : ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed load');
    }
  }

  //POST FUNCTION
  Future<Post> postFunct(String title, String body) async {
    Map<String, dynamic> request = {
      "title": title,
      "body": body,
      "userId": "12",
    };
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.post(uri, body: request);

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed POST');
    }
  }

  //UPDATE
  Future<Post> updatePost(String title, String body) async {
    Map<String, dynamic> request = {
      'id': "101",
      'title': title,
      'body': body,
      'userId': "12"
    };

    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await client.put(url, body: request);

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed POST');
    }
  }

  //DELETE
  Future<Post?> deletePost() async {
    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await client.delete(url);

    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Failed delete');
    }
  }

  //GET CAT
  Future<List<Cat>?> getCats() async {
    var client = http.Client();

    var url = Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10&');
    var response = await client.get(
      url,
      headers: {
        "x-api-key":
            "live_DSPzW4t9atqQerOIbbR5jpxN8gvbI5wV7zoedoo0M1Vu1JkgEUFB6bmtkBah7AOF"
      },
    );
    print('Response status : ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var json = response.body;
      return catfromJson(json);
    } else {
      throw Exception('Failed delete');
    }
  }
}
