import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:dio/dio.dart';

class Downloader {
  void download(String fileUrl, String filename, Function statusHandler) async {
    if (fileUrl != "") {
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

  Downloader(String fileUrl, String filename, Function statusHandler) {
    download(fileUrl, filename, statusHandler);
  }
}
