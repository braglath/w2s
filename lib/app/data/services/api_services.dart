import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:w2s/app/data/models/image_model.dart';

class Data {
  static Future<Model> getData() async {
    http.Response response = await http.get(
        Uri.parse("https://itunes.apple.com/in/rss/topalbums/limit=25/json"));
    // print(response.body);
    if (response.statusCode == 200) {
      var x = Model.fromJson(jsonDecode(response.body));
      return x;
    } else {
      throw 'Error fetching data';
    }
  }
}
