import 'package:flutter/material.dart';
import '../constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnName;
  final Color? backgroundColor;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.btnName,
    this.backgroundColor = kDefaultBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
            fontSize: 18,
            color: backgroundColor == kDefaultBackground
                ? kWhiteTextColor
                : kDefaultBackground,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shadowColor: MaterialStateProperty.all(
            Colors.black45,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
