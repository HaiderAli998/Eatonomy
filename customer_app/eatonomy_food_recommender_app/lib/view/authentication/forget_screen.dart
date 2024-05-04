import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/simple_text_form_field.dart';
import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _forgetEmailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        backgroundColor: ColorsApp.backgroundColorApp,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.008,
              ),
              const Text(
                'Forget Password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: height * 0.003,
              ),
              const Text(
                'Following this step, you can expect to receive \n  an email containing a password reset link.\nBe sure to check both your inbox \n  and spam folder for this message.',
                style: TextStyle(color: ColorsApp.stormGrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.040,
              ),
              SimpleTextField(
                  focusNode: emailFocusNode,
                  controller: _forgetEmailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter Email',
                  prefixIcon: Icons.email_outlined,
                  onFieldSubmitted: (value) {}),
              SizedBox(
                height: height * 0.048,
              ),
              CustomButton('Submit', () {
                auth
                    .sendPasswordResetEmail(
                        email: _forgetEmailController.text.toString())
                    .then((value) {
                  Utils.toastMessage(
                      'We sent you email to recover password, please check email');
                }).onError((error, stackTrace) {
                  Utils.toastMessage(error.toString());
                });
              }, ColorsApp.splashBackgroundColorApp)
            ],
          ),
        ),
      ),
    );
  }
}
