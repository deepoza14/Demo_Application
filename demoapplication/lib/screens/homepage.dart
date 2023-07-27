import 'package:demoapplication/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:demoapplication/model/languagedata.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final int firstListViewLength = 3;
  final int startSrNo = 3;
  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void payment() async {
    double amount = 100 * 100;
    var options = {
      'key': "rzp_test_cy6Y8H27J6FqrZ",
      'amount': amount,
      'currency': 'INR',
      'name': 'Demo.',
      'description': 'Payment Method',
      'timeout': 120,
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: firstListViewLength,
                itemBuilder: (context, index) {
                  final languageData = languageDataList[index];
                  final serialNumber =
                      index + 1; // Adding 1 to start from 1 instead of 0

                  return ListTile(
                    leading: Text('$serialNumber'),
                    // Show serial number starting from 1
                    title: Text(languageData.englishText),
                    subtitle: Text(languageData.hindiText),
                    trailing: const Icon(Icons.lock_open),
                    // Show unlock icon in the trailing position
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Detail(languageData: languageData)));
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languageDataList.length - firstListViewLength,
                  itemBuilder: (context, index) {
                    final languageData =
                        languageDataList[index + firstListViewLength];
                    final serialNumber = index +
                        firstListViewLength +
                        1; // Adding 1 to start from 1 instead of 0

                    return ListTile(
                      leading: Text('$serialNumber'),
                      // Show serial number starting from the desired Sr. No.
                      title: Text(languageData.englishText),
                      subtitle: Text(languageData.hindiText),
                      trailing: const Icon(Icons.lock),
                      // Show lock icon in the trailing position
                      onTap: () {
                        payment();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {}

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
