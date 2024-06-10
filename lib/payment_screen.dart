import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final int amount;

  const PaymentPage({super.key, required this.amount});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openPaymentPortal() async {
    var options = {
      'key': 'rzp_test_LUQCqQKFKMK9oB',
      'amount': widget.amount,
      'name': 'Divya',
      'description': 'Payment',
      'prefill': {'contact': '8500344553', 'email': 'divyabas@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Payment',
            style: TextStyle(fontSize: 22.0, color: Color(0xFF545D68))),
      ),
      body: Column(children: [
        const SizedBox(height: 16.0),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(
                    '\$${(widget.amount / 100).toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(' Price ',
                      style: TextStyle(color: Colors.grey, fontSize: 24.0)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        InkWell(
            onTap: () {
              openPaymentPortal();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                  width: MediaQuery.of(context).size.width - 60.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue.shade900),
                  child: Center(
                      child: Text('Pay',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue.shade50)))),
            ))
      ]),
    );
  }
}
