import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import "../env.dart";

class TikTok {
  static Future<Map> getMediaUrl(String shareURL) async {
    var response = await http.Client().get(
        "https://tiktok-no-watermark1.p.rapidapi.com/?url=$shareURL",
        headers: {
          "x-rapidapi-host": "tiktok-no-watermark1.p.rapidapi.com",
          "x-rapidapi-key": Env.apiKey,
        });
    return json.decode(response.body);
  }
}
