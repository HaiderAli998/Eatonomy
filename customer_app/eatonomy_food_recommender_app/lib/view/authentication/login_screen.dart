import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/res/components/Authentication_Components/social_media_container.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/components/Authentication_Components/login_with_phone_number.dart';
import '../../res/components/Custom_Containers/password_text_form_field.dart';
import '../../res/components/Custom_Containers/simple_text_form_field.dart';
import '../../utils/Utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;
    if (user != null) {
      // Save user details in SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Name', user.displayName ?? 'No Name');
      await prefs.setString('Email', user.email ?? 'No Email');
      await prefs.setString(
          'ProfilePic', user.photoURL ?? 'https://i.imgur.com/VTGxlk8.jpeg');

      Utils.toastMessage("Signed in as ${user.email}");
      return user; // Returning User object for further use
    }
  }
  return null; // Return null if sign-in failed or was aborted
}

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

  void login() async {
    setState(() {
      loading = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Utils.toastMessage("Logged in as ${userCredential.user!.email}");
      if (userCredential.user != null) {
        await _saveUserDetails(userCredential.user!);
        Navigator.pushNamed(context, RoutesName.foodPreferences);
      }
    } catch (error) {
      Utils.toastMessage("Login failed: ${error.toString()}");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // void login() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     );
  //     Utils.toastMessage(userCredential.user!.email.toString());
  //     await _saveUserDetails(userCredential.user!);
  //     Navigator.pushNamed(context, RoutesName.foodPreferences);
  //   } catch (error) {
  //     Utils.toastMessage(error.toString());
  //   } finally {
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  Future<void> _saveUserDetails(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Email', user.email ?? 'No Email');
    await prefs.setString('Name', user.displayName ?? 'No Name');

    // Set a default profile picture if none is set in Firebase
    String defaultProfilePic =
        'https://i.imgur.com/VTGxlk8.jpeg'; // Local asset as default
    await prefs.setString('ProfilePic', user.photoURL ?? defaultProfilePic);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/app_logo_org.svg',
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
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.forgetScreen);
                      },
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
                CustomButton(
                  'Log in',
                  loading: loading,
                  () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  ColorsApp.splashBackgroundColorApp,
                  isEnabled: true,
                ),
                SizedBox(
                  height: height * .0012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have any account? ",
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
                        onPress: () async {
                          try {
                            User? user = await signInWithGoogle();
                            if (user != null) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RoutesName.foodPreferences, (route) => false);
                            } else {
                              Utils.toastMessage(
                                  "No user returned from Google sign-in");
                            }
                          } catch (e) {
                            Utils.toastMessage(
                                "Failed to sign in with Google: $e");
                          }
                        },
                        svgPath: 'assets/icons/google_logo.svg'),
                    SocialMediaBox(
                        text: 'Phone',
                        onPress: () {
                          const LoginWithPhoneNumber();
                          Navigator.pushNamedAndRemoveUntil(
                              context, RoutesName.loginPhone, (route) => false);
                        },
                        svgPath: 'assets/icons/phone_icon.svg'),
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
