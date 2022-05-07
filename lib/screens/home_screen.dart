import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../env.dart';
import '../models/posts_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/post_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  // get all posts
  Future<List<Post>> _getAllPosts() async {
    var url = Uri.parse("${Env.URL_PREFIX_POSTS}/read_all");
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      },
    );
    var res = jsonDecode(response.body)["data"] as List;
    // var tagObjsJson = jsonDecode(arrayObjsText)['tags'] as List;
    List<Post> posts = res.map((data) => Post.fromJson(data)).toList();

    // print(posts.length);
    return posts;
  }

  void _refreshList() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _getAllPosts();
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: _getAllPosts(),
              builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                // print(snapshot.data[0]);
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    onLoading: _getAllPosts,
                    onRefresh: _refreshList,
                    header: const WaterDropHeader(),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      // clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        int itemCount = snapshot.data!.length;
                        int reversedIndex = itemCount - 1 - i;
                        Post post = snapshot.data![reversedIndex];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                            right: 20,
                            bottom: 0,
                          ),
                          child: Column(
                            children: [
                              PostItem(
                                content: post.content,
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                // List<Post> data;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(20),
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: kDefaultBackground,
                                fontSize: kDefaultHeading,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Post',
                              style: TextStyle(color: kWhiteTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autofocus: true,
                      maxLength: 220,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "What's Happening?",
                        border: InputBorder.none,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.image,
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.location_on,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: kDefaultBackground,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
