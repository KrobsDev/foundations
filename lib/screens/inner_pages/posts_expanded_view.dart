import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/expanded_post_item.dart';
import 'package:foundations/widgets/post_item.dart';

class ExpandedPostPage extends StatelessWidget {
  final String? photo;
  final String? profileImage;
  final String? content;
  final VoidCallback? onTap;
  final bool? hideDets;
  const ExpandedPostPage({
    Key? key,
    this.photo,
    this.profileImage,
    this.onTap,
    this.hideDets,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kDefaultBackground),
        title: const Text(
          'Post',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandedPostItem(
            profileImage: profileImage,
            photo: photo!,
            content: content,
          ),
          Divider(),
        ],
      )),
    );
  }
}
