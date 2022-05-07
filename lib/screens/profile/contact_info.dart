import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/custom_button.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailcontroller = TextEditingController();
    final TextEditingController _phonecontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: kDefaultBackground,
        ),
        title: const Text(
          'Contact Information',
          style: TextStyle(color: kDefaultBackground),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: const Text(
              //     'Update your contact information',
              //     style: TextStyle(fontSize: kDefaultHeading),
              //   ),
              // ),
              Flexible(
                child: TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    labelStyle: TextStyle(color: inactiveColor),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: inactiveColor,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: inactiveColor.withOpacity(0.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kDarkTextColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: TextFormField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    label: const Text('Phone Number'),
                    labelStyle: TextStyle(color: inactiveColor),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: inactiveColor,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: inactiveColor.withOpacity(0.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kDarkTextColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer(),
              // Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: CustomButton(
            onPressed: () {}, btnName: 'Update Contact Information'),
      ),
    );
  }
}
