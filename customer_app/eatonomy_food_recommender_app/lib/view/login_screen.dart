import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/password_text_form_field.dart';
import 'package:eatonomy_food_recommender_app/res/components/round_button.dart';
import 'package:eatonomy_food_recommender_app/res/components/social_media_container.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../res/components/simple_text_form_field.dart';
import '../utils/Utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  final _auth = FirebaseAuth.instance;

  //Focus Node
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool _checkbox = false;

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text.toString())
        .then((value) {
      Utils.toastMessage(value.user!.email.toString());
      Navigator.pushNamed(context, RoutesName.foodPreferences);
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 18,bottom: 195),
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
                  height: 60,
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 24,
                              color: ColorsApp.darkGrey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * .002,
                        ),
                        const Text(
                          'Sign in to your Account',
                          style: TextStyle(
                              fontSize: 14, color: ColorsApp.stormGrey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .024,
                ),
                Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: _formKey,
                    child: Column(
                      children: [
                        SimpleTextField(
                          controller: _emailController,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(context, passwordFocusNode);
                          },
                        ),
                        SizedBox(
                          height: height * 0.016,
                        ),
                        CustomPasswordField(
                            controller: _passwordController,
                            focusNode: passwordFocusNode,
                            hintText: 'Enter Password',
                            obscurePassword: _obscurePassword),
                      ],
                    )),
                SizedBox(
                  height: height * .0012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                          'Remember me',
                          style: TextStyle(
                              color: ColorsApp.neutralN40, fontSize: 14),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forget Password ?',
                        style: TextStyle(
                            color: ColorsApp.splashBackgroundColorApp,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                ColorsApp.splashBackgroundColorApp),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .068,
                ),
                CustomButton('Log in',loading: loading, () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                }, ColorsApp.splashBackgroundColorApp),
                SizedBox(
                  height: height * .0012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "haven't any account? ",
                      style: TextStyle(color: ColorsApp.neutralN40),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.signUP);
                      },
                      child: const Text(
                        'Sign up',
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
