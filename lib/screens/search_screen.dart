import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: inactiveColor.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kDefaultBackground),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: kDefaultBackground,
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
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text('Ghana Residential Fund'),
            trailing: Icon(CupertinoIcons.arrow_up_right),
          ),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text('Help A Child'),
            trailing: Icon(CupertinoIcons.arrow_up_right),
          )
        ],
      ),
    );
  }
}
