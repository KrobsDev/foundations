import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foundations/models/charity_model.dart';
import '../constants.dart';
import '../env.dart';
import '../widgets/charity_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchcontroller = TextEditingController();
  List<CharityModel> _list = [];
  bool _isSearching = false;
  String _searchText = "";
  List<CharityModel> searchresult = [];

  Icon icon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  _SearchPageState() {
    _searchcontroller.addListener(() {
      if (_searchcontroller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchcontroller.text;
        });
      }
    });
  }

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

    List<CharityModel> charities =
        res.map((data) => CharityModel.fromJson(data)).toList();

    // print(posts.length);
    _list = [];

    for (var item in charities) {
      _list.add(item);
    }
    // print(products.length);
    return _list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
    _getAllCharities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Image(
          image: AssetImage('assets/logo/logo-dark-sm.png'),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: TextFormField(
                controller: _searchcontroller,
                onChanged: searchOperation,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: inactiveColor.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kDefaultBackground),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: kDefaultBackground,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        searchresult.length = 0;
                        _searchcontroller.clear();
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                  hintText: 'Explore charities',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Recent Searches',
              style: TextStyle(color: inactiveColor),
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: searchresult != '' || _searchcontroller.text != ''
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: FutureBuilder<List<CharityModel>>(
                      future: _getAllCharities(),
                      builder: (context,
                          AsyncSnapshot<List<CharityModel>> snapshot) {
                        // print(snapshot.data[0]);
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: searchresult.length,
                            scrollDirection: Axis.vertical,
                            // clipBehavior: Clip.none,
                            shrinkWrap: true,
                            itemBuilder: (_, i) {
                              CharityModel charity = searchresult[i];
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
                          );
                        }
                        // List<Post> data;
                      },
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
          )
        ],
      ),
    );
  }

  void _handleSearchEnd() {
    setState(() {
      icon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      _isSearching = false;
      _searchcontroller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        CharityModel data = _list[i];
        if (data.name!.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
