import 'package:eatonomy_food_recommender_app/res/components/password_text_form_field.dart';
import 'package:eatonomy_food_recommender_app/res/components/simple_text_form_field.dart';
import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../res/components/colors_app.dart';
import '../res/components/round_button.dart';
import '../res/components/social_media_container.dart';
import '../utils/routes/routes_name.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool loading = false;

  //Used to notify the empty from field
  final _formKey = GlobalKey<FormState>();

  //Form Field Controllers which hold the values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);

  //Focus Node
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  bool _checkbox = false;

  // instance of firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

//dispose is used to free the memory when the object is no more build again
  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/app_logo_org.svg',
                    height: 79,
                    width: 79,
                  ),
                ),
                SizedBox(height: height * .020),
                SizedBox(
                  height: 80,
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 24,
                              color: ColorsApp.darkGrey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * .002,
                        ),
                        const Text(
                          'Please create your account by \n filling out the form below.',
                          style: TextStyle(color: ColorsApp.stormGrey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: height * .024),
                        SimpleTextField(
                            controller: _nameController,
                            focusNode: nameFocusNode,
                            keyboardType: TextInputType.name,
                            hintText: 'Name',
                            prefixIcon: Icons.person_2_outlined,
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(context, emailFocusNode);
                            }),
                        SizedBox(
                          height: height * .010,
                        ),
                        SimpleTextField(
                            controller: _emailController,
                            focusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(
                                  context, passwordFocusNode);
                            }),
                        SizedBox(
                          height: height * .010,
                        ),
                        CustomPasswordField(
                          controller: _passwordController,
                          focusNode: passwordFocusNode,
                          obscurePassword: _obscurePassword,
                          hintText: 'Enter Password',
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context, rePasswordFocusNode);
                          },
                        ),
                        SizedBox(
                          height: height * .010,
                        ),
                        CustomPasswordField(
                            controller: _confirmPasswordController,
                            focusNode: rePasswordFocusNode,
                            hintText: 'Re_Enter Password',
                            obscurePassword: _obscurePassword),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Align items to the start
                  children: [
                    Transform.scale(
                      scale: 0.7,
                      child: Checkbox(
                        value: _checkbox,
                        onChanged: (value) {
                          setState(
                            () {
                              _checkbox = value!;
                            },
                          );
                        },
                        activeColor: ColorsApp.splashBackgroundColorApp,
                        checkColor: Colors.white,
                      ),
                    ),
                    const Text(
                      'I accept the terms and conditions',
                      style:
                          TextStyle(color: ColorsApp.neutralN40, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .030,
                ),
                CustomButton(
                  'Sign up',
                  () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        Utils.toastMessage('Please enter correct password');
                        rePasswordFocusNode.requestFocus();
                      } else {
                        _auth
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.toString(),
                                password: _passwordController.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils.toastMessage(error.toString());
                        });
                      }
                    }
                  },
                  ColorsApp.splashBackgroundColorApp,
                  loading: loading,
                ),
                SizedBox(
                  height: height * .012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ",
                      style: TextStyle(color: ColorsApp.neutralN40),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RoutesName.login, (route) => false);
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                            color: ColorsApp.splashBackgroundColorApp),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .052,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    const Text('  Sign in with  '),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.024,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialMediaBox(
                        text: 'Google',
                        onPress: () {},
                        svgPath: 'assets/google_logo.svg'),
                    SocialMediaBox(
                        text: 'FACEBOOK',
                        onPress: () {},
                        svgPath: 'assets/fb_logo.svg'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
