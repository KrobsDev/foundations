import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/expanded_post_item.dart';
import 'package:foundations/widgets/post_item.dart';

class ExpandedPostPage extends StatelessWidget {
  const ExpandedPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kDefaultBackground),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ExpandedPostItem(),
        ],
      )),
    );
  }
}
