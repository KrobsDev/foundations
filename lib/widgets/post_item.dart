import 'package:flutter/material.dart';

import '../constants.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://images.unsplash.com/photo-1629425733761-caae3b5f2e50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhlYWRzaG90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                'Nana Akwasi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5),
              Text(
                '@nakwasi23',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
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
        children: [
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam tellus sed orci viverra eros, nisl egestas sed diam. Quam condimentum eget dictum a.',
            style: TextStyle(
              color: Colors.black87,
              fontSize: kDefaultFontSize,
            ),
          ),
          const SizedBox(height: 5),
          Row(
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
          ),
          const Divider(),
        ],
      ),
      // trailing: Icon(Icons.more_horiz),
    );
  }
}
