import 'package:flutter/material.dart';
import 'package:foundations/screens/inner_pages/charity_info.dart';

import '../constants.dart';

class CharityItem extends StatelessWidget {
  final String title;
  final String image;
  final String amount;

  const CharityItem({
    Key? key,
    required this.title,
    required this.image,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => CharityDetail(
            title: title,
            image: image,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              // border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: title,
                child: Image(
                  fit: BoxFit.cover,
                  image: image.isNotEmpty
                      ? NetworkImage(image)
                      : Image.asset("assets/images/no-image-icon-20.png").image,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: kDefaultHeading,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: double.parse(amount.replaceAll(',', '')) / 100000,
            color: kDefaultBackground,
            backgroundColor: inactiveColor.withOpacity(0.09),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
