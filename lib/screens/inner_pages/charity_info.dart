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
    final TextEditingController _donationAmount = TextEditingController();
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
                      child: image.isNotEmpty
                          ? Image.network(
                              image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/no-image-icon-20.png"),
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
                CustomButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            // height: 400,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Donation',
                                      style:
                                          TextStyle(color: kDefaultBackground),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: inactiveColor,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Flexible(
                                  child: TextFormField(
                                    controller: _donationAmount,
                                    decoration: InputDecoration(
                                      label: const Text('Amount'),
                                      labelStyle: const TextStyle(
                                          color: kDefaultBackground),
                                      hintText:
                                          'Enter amount you wish to donate',
                                      hintStyle: TextStyle(
                                        color: inactiveColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.attach_money,
                                        color: kDarkTextColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: inactiveColor),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: inactiveColor),
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              kDarkTextColor.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'We appreciate the effort. Rest assured that your donation will be put to good use. You are a blessing to many. Thank you for the kind gesture',
                                  style: TextStyle(height: 1.5),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                      // border: Border.all(),
                                      ),
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/images/undraw_Gifts_re_97j6.png"),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Spacer(),
                                CustomButton(
                                    onPressed: () {}, btnName: 'Donate')
                              ],
                            ),
                          );
                        },
                      );
                    },
                    btnName: 'Support this project'),
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
