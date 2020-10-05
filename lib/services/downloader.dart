import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class Downloader {
  static void download(
      String fileUrl, String filename, Function statusHandler) async {
    if (fileUrl != "") {
      print("Downloading: $fileUrl");
      Directory tmpDir = await getTemporaryDirectory();
      final String tmpFile = tmpDir.path + "/$filename";
      // Download remote file using Dio to temporary directory
      await Dio().download(
        fileUrl,
        tmpFile,
        options: Options(
          headers: {
            "Referer": "https://www.tiktok.com/foryou",
          },
        ),
      );
      print("Downlaoded video file");
      // now save the file downloaded to temporary directory to gallery using GallerySaver
      GallerySaver.saveVideo(tmpFile);
      print("Saved video to gallery");
      statusHandler("Download Complete");
    }
  }
}
