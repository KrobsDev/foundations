import 'package:flutter/material.dart';
import 'package:foundations/screens/inner_pages/posts_expanded_view.dart';
import 'package:foundations/screens/inner_pages/show_full_image.dart';
// import 'package:photo_view/photo_view.dart';
import '../constants.dart';

class PostItem extends StatelessWidget {
  final String? photo;
  final String? profileImage;
  final String? content;
  final VoidCallback? onTap;
  final bool? hideDets;
  const PostItem({
    Key? key,
    this.profileImage = "",
    this.photo = "",
    this.onTap,
    this.content = "",
    this.hideDets = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => ExpandedPostPage(
                  photo: photo,
                  profileImage: profileImage,
                  content: content,
                ),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundColor: inactiveColor.withOpacity(0.2),
            backgroundImage: profileImage!.isNotEmpty
                ? NetworkImage(
                    profileImage!,
                    // "https://images.unsplash.com/photo-1629425733761-caae3b5f2e50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhlYWRzaG90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
                  )
                : Image.asset("assets/images/avatar-image.png").image,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    'Akwasi Asante',
                    style: TextStyle(
                      fontSize: kDefaultFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '@ak@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.more_horiz,
                  color: inactiveColor.withOpacity(0.2),
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content!,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: kDefaultFontSize,
                ),
              ),
              const SizedBox(height: 5),
              photo!.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenImg(photo: photo!)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: photo!,
                            child: Image(
                              fit: BoxFit.cover,
                              image: photo != null
                                  ? NetworkImage(photo!)
                                  : Image.asset(
                                      "assets/images/no-image-icon-20.png",
                                    ).image,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 5),
              hideDets!
                  ? const SizedBox(
                      height: 0,
                    )
                  : Row(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(width: 2),
                            Text('200')
                          ],
                        ),
                        const SizedBox(width: 15),
                        Row(
                          children: const [
                            Icon(
                              Icons.bubble_chart,
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(width: 2),
                            Text('10')
                          ],
                        ),
                      ],
                    )
              // const Divider(),
            ],
          ),
          // trailing: Icon(Icons.more_horiz),
        ),
        // const Divider()
      ],
    );
  }
}
