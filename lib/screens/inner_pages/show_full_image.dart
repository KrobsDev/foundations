import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';

class FullScreenImg extends StatelessWidget {
  final String photo;
  const FullScreenImg({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: kDefaultBackground,
      body: Center(
        child: Hero(
          tag: photo,
          child: Image(
            image: Image.network(photo).image,
          ),
        ),
      ),
    );
  }
}
