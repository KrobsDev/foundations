import 'package:flutter/material.dart';
import 'package:foundations/widgets/charity_item.dart';
import '../../constants.dart';

class DonationsPage extends StatelessWidget {
  const DonationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: kDefaultBackground,
        ),
        title: const Text(
          'Donations',
          style: TextStyle(color: kDefaultBackground),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Charities you have donated to',
                style: TextStyle(fontSize: kDefaultHeading),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: inactiveColor.withOpacity(0.2),
                child: const Icon(
                  Icons.attach_money,
                  color: kDefaultBackground,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Ghana Residential Fund'),
                ],
              ),
              subtitle: const Text('You donated GHS 50,000'),
            )
          ],
        ),
      )),
    );
  }
}
