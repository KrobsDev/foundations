import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/custom_button.dart';

class CharityDetail extends StatelessWidget {
  final String title;
  final String image;
  const CharityDetail({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = '2,000';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      extendBody: true,
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: title,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 5),
                const Text(
                  'Ghana Residential Fund',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: double.parse(amount.replaceAll(',', '')) / 100000,
                  color: kDefaultBackground,
                  backgroundColor: inactiveColor.withOpacity(0.09),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Raised',
                      style: TextStyle(
                        color: inactiveColor,
                      ),
                    ),
                    Text(
                      'GHS ${amount}',
                      style: const TextStyle(
                        fontSize: kDefaultHeading,
                        fontWeight: FontWeight.bold,
                        color: kDefaultBackground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: inactiveColor.withOpacity(0.2),
                    // backgroundImage: Image.network("").image,
                    backgroundImage: Image.asset(
                      "assets/images/avatar-image.png",
                      fit: BoxFit.cover,
                    ).image,
                  ),
                  title: const Text('Marcus Androza'),
                  subtitle: const Text('mardoza@gmail.com'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 25),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi lorem nunc laoreet aliquet. psum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi lorem nunc laoreet aliquet. psum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi lorem nunc laoreet aliquet. psum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi lorem nunc laoreet aliquet. psum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi lorem nunc laoreet aliquet. psum dolor sit amet, consectetur adipiscing',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                CustomButton(onPressed: () {}, btnName: 'Support this project'),
                // const Padding(
                //   padding: EdgeInsets.all(20),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
