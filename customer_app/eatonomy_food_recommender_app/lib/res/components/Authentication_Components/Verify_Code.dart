import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom_Containers/Custom_button.dart';
import '../colors_app.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationID;

  const VerifyCodeScreen({super.key, required this.verificationID});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final codeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Verify')),
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
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '6 digit code',
              ),
            ),
            SizedBox(
              height: height * 0.080,
            ),
            CustomButton('Verify', loading: loading, () async {
              setState(() {
                loading = true;
              });
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationID,
                  smsCode: codeController.text.toString());
              try {
                await auth.signInWithCredential(credential);
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.homeScreen, (route) => false);
              } catch (e) {
                setState(() {
                  loading = false;
                });
                Utils.toastMessage(e.toString());
              }
            }, ColorsApp.splashBackgroundColorApp)
          ],
        ),
      ),
    );
  }
}
