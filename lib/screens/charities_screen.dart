import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:foundations/models/charity_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants.dart';
import '../env.dart';
import '../widgets/charity_item.dart';
import '../widgets/custom_appbar.dart';

class CharitiesPage extends StatefulWidget {
  const CharitiesPage({Key? key}) : super(key: key);

  @override
  State<CharitiesPage> createState() => _CharitiesPageState();
}

class _CharitiesPageState extends State<CharitiesPage> {

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // get all posts
  Future<List<CharityModel>> _getAllCharities() async {
    var url = Uri.parse("${Env.URL_PREFIX_CHAR}/read_all.php");
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      },
    );
    var res = jsonDecode(response.body)["data"] as List;
    // var tagObjsJson = jsonDecode(arrayObjsText)['tags'] as List;
    List<CharityModel> charities =
        res.map((data) => CharityModel.fromJson(data)).toList();

    // print(posts.length);
    return charities;
  }

  void _refreshList() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _getAllCharities();
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllCharities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Trending Charities',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: FutureBuilder<List<CharityModel>>(
                future: _getAllCharities(),
                builder: (context, AsyncSnapshot<List<CharityModel>> snapshot) {
                  // print(snapshot.data[0]);
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      onLoading: _getAllCharities,
                      onRefresh: _refreshList,
                      header: const WaterDropHeader(),
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        // clipBehavior: Clip.none,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          int itemCount = snapshot.data!.length;
                          int reversedIndex = itemCount - 1 - i;
                          CharityModel charity = snapshot.data![reversedIndex];
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 0,
                              right: 0,
                              bottom: 0,
                            ),
                            child: Column(
                              children: [
                                CharityItem(
                                  title: charity.name!,
                                  image: charity.image!,
                                  id: charity.cid!,
                                  description: charity.description!,
                                  amount: charity.amount!,
                                  target: charity.target!,
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
            )
            // const CharityItem(
            //   title: 'Ghana Residential Fund',
            //   image:
            //       "https://images.unsplash.com/photo-1504159506876-f8338247a14a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGNoYXJpdHl8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
            //   amount: '1,200',
            // ),
            // const CharityItem(
            //   title: 'Help A Child',
            //   image:
            //       "https://images.unsplash.com/photo-1636202339022-7d67f7447e3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGNoYXJpdHl8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
            //   amount: '50,000',
            // ),
            // const CharityItem(
            //   title: 'Streetism Out',
            //   image:
            //       "https://images.unsplash.com/photo-1459183885421-5cc683b8dbba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2hhcml0eXxlbnwwfDB8MHx8&auto=format&fit=crop&w=900&q=60",
            //   amount: '23,000',
            // ),
          ],
        ),
      ),
    );
  }
}
