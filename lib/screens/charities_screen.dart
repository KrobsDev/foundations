import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../constants.dart';
import '../widgets/charity_item.dart';
import '../widgets/custom_appbar.dart';

class CharitiesPage extends StatefulWidget {
  const CharitiesPage({Key? key}) : super(key: key);

  @override
  State<CharitiesPage> createState() => _CharitiesPageState();
}

class _CharitiesPageState extends State<CharitiesPage> {
  String dropdownValue = 'Accra';

  List<String> places = [
    'Accra',
    'Kumasi',
    'Bolga',
    'Oti',
    'Obuasi',
    'Cape Coast',
    'Ho',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Search Charities by location'),
              const SizedBox(height: 10),
              DropdownButtonFormField2(
                isExpanded: true,
                value: dropdownValue,
                dropdownPadding: const EdgeInsets.all(0),
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value as String;
                  });
                },
                items: places.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Trending Charities in $dropdownValue',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 10),
              const CharityItem(
                title: 'Ghana Residential Fund',
                image:
                    "https://images.unsplash.com/photo-1504159506876-f8338247a14a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGNoYXJpdHl8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
                amount: '1,200',
              ),
              const CharityItem(
                title: 'Help A Child',
                image:
                    "https://images.unsplash.com/photo-1636202339022-7d67f7447e3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGNoYXJpdHl8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60",
                amount: '50,000',
              ),
              const CharityItem(
                title: 'Streetism Out',
                image:
                    "https://images.unsplash.com/photo-1459183885421-5cc683b8dbba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2hhcml0eXxlbnwwfDB8MHx8&auto=format&fit=crop&w=900&q=60",
                amount: '23,000',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
