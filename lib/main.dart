import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import './widgets/search.dart';
import './widgets/video.dart';
import './services/tiktok.dart';

void main() => runApp(MaterialApp(
      title: "TikTok Video Downloader",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var videoData;

  bool hasVideoData = false;

  void parseVideo(String videoUrl) async {
    if (isURLValid(videoUrl)) {
      Map tikTokData = await TikTok.getMediaUrl(videoUrl);
      //print(tikTokData);
      if (tikTokData.containsKey('video')) {
        setState(() {
          videoData = tikTokData;
          hasVideoData = true;
        });
      }
    }
  }

  static bool isURLValid(String url) {
    RegExp tiktokCheck = new RegExp(r"^https?:\/\/([^]+)\.tiktok\.com");
    if (tiktokCheck.hasMatch(url)) {
      print("valid URL $url");
      return true;
    }
    print("invalid URL $url");

    return false;
  }

  void resetState() {
    setState(() {
      hasVideoData = false;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (await Permission.storage.request().isGranted) {
      print('approved write permission to storage');
    } else {
      print('denied write permission to storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TikTok Downloader"),
        ),
        body: Center(
          child: hasVideoData
              ? Video(videoData, resetState)
              : SearchBar(parseVideo),
        ));
  }
}
