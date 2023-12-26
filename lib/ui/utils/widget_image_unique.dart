import 'package:flutter/material.dart';

class WidgetImageUnique extends StatelessWidget {
  final String urlImage;

  WidgetImageUnique(this.urlImage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text("")),
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Image.network(urlImage),
      ),
    );
  }
}
