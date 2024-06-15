import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Add this import for toast messages

class PaymentMethod extends StatefulWidget {
  final String address;

  const PaymentMethod({super.key, required this.address});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isPayOnArrivalSelected = false; // Add this variable to track selection

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.backgroundColorApp,
        appBar: AppBar(
          backgroundColor: ColorsApp.backgroundColorApp,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorsApp.neutralN10,
                          border: Border.all(color: ColorsApp.paleGrey)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Total",
                              style: TextStyle(
                                  color: ColorsApp.darkGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              "100",
                              style: TextStyle(
                                  color: ColorsApp.darkGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 72,
                      decoration: BoxDecoration(
                          color: ColorsApp.neutralN10,
                          border: Border.all(color: ColorsApp.paleGrey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                  textScaler: const TextScaler.linear(1.05)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                child: Text(
                                  widget.address,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      color: ColorsApp.darkGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 2,
                      color: ColorsApp.neutralN30,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Payment",
                      style: TextStyle(
                          color: ColorsApp.darkGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPayOnArrivalSelected = !isPayOnArrivalSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: isPayOnArrivalSelected
                              ? ColorsApp.splashBackgroundColorApp
                              : ColorsApp.neutralN10,
                          border: Border.all(
                            color: ColorsApp.paleGrey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                    textScaler: const TextScaler.linear(1.05)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  child: Center(
                                    child: Text(
                                      "Pay on Arrival",
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: isPayOnArrivalSelected
                                            ? Colors.white
                                            : ColorsApp.darkGrey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: CustomButton(
                "Proceed to Payment",
                () {
                  if (isPayOnArrivalSelected) {
                    _showToast("Proceed to Payment button clicked");
                  }
                },
                ColorsApp.splashBackgroundColorApp,
                isEnabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
