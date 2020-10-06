import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  final Function inputHandler;
  SearchBar(this.inputHandler);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: TextFormField(
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          hintText: "Enter TikTok video url",
        ),
        // TODO: Integrate full screen adverisements
        // TODO: Add a loading icon
        onFieldSubmitted: (val) {
          // Probably a good time to display an advert as processing cal take a couple of seconds to process url results via API
          inputHandler(val);
        },
      ),
    );
  }
}
