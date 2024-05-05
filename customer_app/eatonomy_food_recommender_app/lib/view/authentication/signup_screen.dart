import 'package:eatonomy_food_recommender_app/res/components/Authentication_Components/Login_with_phone_number.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/simple_text_form_field.dart';
import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/components/Authentication_Components/Google_SignIn.dart';
import '../../res/components/Custom_Containers/password_text_form_field.dart';
import '../../res/components/Colors/colors_app.dart';
import '../../res/components/Custom_Containers/Custom_button.dart';
import '../../res/components/Authentication_Components/social_media_container.dart';
import '../../utils/routes/routes_name.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    ValueNotifier userCredential = ValueNotifier('');
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
                  () async {
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        Utils.toastMessage('Passwords do not match.');
                        rePasswordFocusNode.requestFocus();
                        return;
                      }

                      setState(() {
                        loading = true;
                      });

                      try {
                        // Create the user with email and password
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        // Check if user is not null and update their display name
                        User? user = userCredential.user;
                        if (user != null) {
                          await user
                              .updateDisplayName(_nameController.text.trim());
                          await user
                              .reload(); // Reload the user data from Firebase

                          // Optionally, save the name and email to SharedPreferences
                          await addNameToSP();

                          // Navigate or perform other actions
                          Navigator.pushNamedAndRemoveUntil(context,
                              RoutesName.foodPreferences, (route) => false);
                          Utils.toastMessage('Account created successfully!');
                        }
                      } catch (e) {
                        Utils.toastMessage('Failed to create account: $e');
                        setState(() {
                          loading = false;
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
                        onPress: () async {
                          GoogleSignIn googleSignIn = GoogleSignIn();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          try {
                            GoogleSignInAccount? googleUser =
                                await googleSignIn.signIn();
                            if (googleUser != null) {
                              GoogleSignInAuthentication googleAuth =
                                  await googleUser.authentication;

                              final OAuthCredential credential =
                                  GoogleAuthProvider.credential(
                                accessToken: googleAuth.accessToken,
                                idToken: googleAuth.idToken,
                              );

                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithCredential(credential);
                              User? user = userCredential.user;

                              if (user != null) {
                                // Store user details in SharedPreferences
                                await prefs.setString(
                                    'Name', user.displayName ?? 'No Name');
                                await prefs.setString(
                                    'Email', user.email ?? 'No Email');
                                await prefs.setString(
                                    'ProfilePic', user.photoURL ?? 'https://i.imgur.com/VTGxlk8.jpeg');

                                // Navigate or perform other actions
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesName.foodPreferences,
                                    (route) => false);
                                Utils.toastMessage(
                                    'Signed in with Google successfully!');
                              }
                            }
                          } catch (e) {
                            Utils.toastMessage(
                                'Failed to sign in with Google: $e');
                          }
                        },
                        svgPath: 'assets/google_logo.svg'),
                    SocialMediaBox(
                        text: 'Phone ',
                        onPress: () {
                          const LoginWithPhoneNumber();
                          Navigator.pushNamedAndRemoveUntil(
                              context, RoutesName.loginPhone, (route) => false);
                        },
                        svgPath: 'assets/phone_icon.svg'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addNameToSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Name', _nameController.text);
    await prefs.setString('Email', _emailController.text);
  }
}
