import 'package:flutter/material.dart';
import '../services/downloader.dart';

class Video extends StatefulWidget {
  final _videoData;
  final Function resetStateHandler;
  Video(this._videoData, this.resetStateHandler);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String statusText = "";
  void setDownloadStatus(String _statusText) {
    setState(() {
      statusText = _statusText;
    });
  }

  @override
  Widget build(BuildContext context) {
    List extraWidgets = [];
    if (statusText != "") {
      extraWidgets.add(Text(
        statusText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.green,
        ),
      ));
    }
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Image(
          image: NetworkImage(widget._videoData['video']['cover']),
          height: 250,
          fit: BoxFit.contain,
        ),
        RaisedButton(
          child: Text("Download Video"),
          onPressed: () {
            setDownloadStatus("Downloading.. please wait");
            Downloader(
              widget._videoData['video']['playAddr'],
              widget._videoData['id'] + '.mp4',
              setDownloadStatus,
            );
          },
        ),
        RaisedButton(
          child: Text("Download Video (No Watermark)"),
          onPressed: () {
            setDownloadStatus("Downloading video without watermark");
            Downloader(
              widget._videoData['video']['noWatermark'],
              widget._videoData['id'] + 'no-watermark.mp4',
              setDownloadStatus,
            );
          },
        ),
        ...extraWidgets,
        FlatButton(
          child: Text("Download another video"),
          onPressed: widget.resetStateHandler,
        )
      ],
    );
  }
}
