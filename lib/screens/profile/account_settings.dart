import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/custom_button.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _oldpwcontroller = TextEditingController();
    final TextEditingController _newpwcontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: kDefaultBackground,
        ),
        title: const Text(
          'Account Settings',
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
                  controller: _oldpwcontroller,
                  decoration: InputDecoration(
                    label: const Text('Old Password'),
                    labelStyle: TextStyle(color: inactiveColor),
                    hintText: 'Old Password',
                    hintStyle: TextStyle(
                      color: inactiveColor,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
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
                  controller: _newpwcontroller,
                  decoration: InputDecoration(
                    label: const Text('New Password'),
                    labelStyle: TextStyle(color: inactiveColor),
                    hintText: 'New Password',
                    hintStyle: TextStyle(
                      color: inactiveColor,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
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
          onPressed: () {},
          btnName: 'Update Account Information',
        ),
      ),
    );
  }
}
