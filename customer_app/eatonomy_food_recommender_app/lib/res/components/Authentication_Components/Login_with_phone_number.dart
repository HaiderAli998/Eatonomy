import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/res/components/Authentication_Components/Verify_Code.dart';
import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login')),
        backgroundColor: ColorsApp.splashBackgroundColorApp,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.080,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+1 234 3455 234',
              ),
            ),
            SizedBox(
              height: height * 0.080,
            ),
            CustomButton('Login', loading: loading, () {
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    Utils.toastMessage(e.toString());
                  },
                  codeSent: (String verificationID, int? Token) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCodeScreen(
                                verificationID: verificationID)));
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils.toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  });
            }, ColorsApp.splashBackgroundColorApp)
          ],
        ),
      ),
    );
  }
}
