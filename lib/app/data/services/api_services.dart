import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:w2s/app/data/models/image_model.dart' as model;

class Data {
  static Future<model.Model> getData() async {
    http.Response response = await http.get(
        Uri.parse("https://itunes.apple.com/in/rss/topalbums/limit=25/json"));
    print(response.body);
    var x = model.Model.fromJson(jsonDecode(response.body));
    return x;
  }
}
