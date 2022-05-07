import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/post_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            PostItem(
              profileImage:
                  "https://images.unsplash.com/photo-1629425733761-caae3b5f2e50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhlYWRzaG90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
              photo:
                  "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2hhcml0eXxlbnwwfDB8MHx8&auto=format&fit=crop&w=900&q=60",
            ),
            PostItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kDefaultBackground,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
