import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import '../../env.dart';
import '../../models/user_model.dart';
import '../../widgets/paybutton.dart';

class CharityDetail extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String description;
  final String amount;
  final String target;

  const CharityDetail({
    Key? key,
    required this.title,
    required this.image,
    required this.id,
    required this.description,
    required this.amount,
    required this.target,
  }) : super(key: key);

  @override
  State<CharityDetail> createState() => _CharityDetailState();
}

class _CharityDetailState extends State<CharityDetail> {
  final TextEditingController _amountcontroller = TextEditingController();

  int? uid;

  bool isLoading = false;

  // function check if user is logged in
  Future _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getInt("uid");
    });

    // print(uid);
  }

  // User object to use throughout page
  User? user;

  // get user details
  Future _getUserDetails() async {
    var url = Uri.parse("${Env.URL_ENDPOINT_USERS}/read_single.php?id=$uid");
    var response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    var res = jsonDecode(response.body);

    // get user in user object
    Map<String, dynamic> userMap = res;
    User userObj = User.fromJson(userMap);

    // print(user.email);
    setState(() {
      user = userObj;
    });

    // print(user!.email);
  }

  // add donation
  Future _makeDonation() async {
    var data = jsonEncode({
      "uid": uid,
      "cid": widget.id,
      "amount": _amountcontroller.text,
    });
    var url = Uri.parse("${Env.URL_ENDPOINT_CHAR}/read_all.php");
    var response = await http.post(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      },
    );
    var res = jsonDecode(response.body);
  }

  String publicKeyTest = 'pk_test_1b76c2f2510013d9f5d7448d8b980d760e346b27';
  //pass in the public test key obtained from paystack dashboard here

  final plugin = PaystackPlugin();

  //a method to show the message
  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //used to generate a unique reference for payment
  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  //async method to charge users card and return a response
  chargeCard() async {
    var charge = Charge()
      ..amount = 100 * 100

      //the money should be in kobo hence the need to multiply the value by 100
      ..reference = _getReference()
      ..putCustomField('custom_id',
          '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..email = user == null ? '' : user!.email
      ..currency = 'GHS';

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    //check if the response is true or not
    if (response.status == true) {
      //you can send some data from the response to an API or use webhook to record the payment on a database
      var url = Uri.parse(
          'https://api.paystack.co/transaction/verify/${response.reference}');
      var pResponse = await http.get(url, headers: {
        "Authorization":
            "Bearer sk_test_cc71bd31eecb6824fe24cc448e9bf2aa3982f110"
      });
      var res = jsonDecode(pResponse.body);
      // add orders to database

      _showMessage('Payment was successful!!!');
    } else {
      //the payment wasn't successsful or the user cancelled the payment
      // print(response.reference);
      _showMessage('Payment Failed!!!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugin.initialize(publicKey: publicKeyTest);
    _isLoggedIn().whenComplete(() {
      _getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _donationAmount = TextEditingController();
    // var amount = '2,000';
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
                      tag: widget.title,
                      child: widget.image.isNotEmpty
                          ? Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/no-image-icon-20.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 5),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value:
                      double.parse(widget.amount.replaceAll(',', '')) / 100000,
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
                      'GHS ${widget.amount}',
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
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
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
                                PayButton(
                                  //call the chargeCard method
                                  callback: () => chargeCard(),
                                ),
                                // CustomButton(
                                //     onPressed: () {}, btnName: 'Donate')
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
