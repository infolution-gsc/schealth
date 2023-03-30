// Sign In or Log in Page
// This page is used to sign in or log in to the app

// ignore_for_file: depend_on_referenced_packages, unused_import, avoid_print, no_leading_underscores_for_local_identifiers, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_planner/screens/auth/signup.dart';
import 'package:healthy_planner/screens/dashboard.dart';
import 'package:healthy_planner/screens/start/fisrt.dart';
import 'package:healthy_planner/widget/navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_planner/widget/transitions/size_transitions.dart';
import 'package:healthy_planner/widget/transitions/slide_transitions.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isEnable = false;

  var auth = FirebaseAuth.instance;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Navigation()));
      }
    });
  }

  late bool _passwordVisible;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkIfLogin();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisible = true;

    _emailController.text = "infolution@admin.com";
    _passwordController.text = "infolution";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  static Future<User?> loginUsingEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
      }
    }
    return user;
  }

  static Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    User? user;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    user = userCredential.user;
    return user;
    // Once signed in, return the UserCredential
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Text field controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xFFFAFAFA),

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, SlideRightRoute(page: const FirstStart()));
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF2756A5)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          child: Image.asset(
                        // Import imgae from folder assets
                        'assets/illustration/login.png',
                        height: 205,
                        width: 400,
                        alignment: Alignment.center,
                      )),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Hello Again!',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        'Welcome back you’ve been missed',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Material(
                                shadowColor: const Color.fromARGB(150, 0, 0, 0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                elevation: 10,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Color(0xFF5B96F8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter email';
                                    } else if (!value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 20.0, end: 20.0),
                                      child: Icon(Icons.mail),
                                    ),
                                    prefixIconColor: Color(0xFF5B96F8),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 0, color: Color(0xFFF5F5F5)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFF5B96F8)),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: Color(0xFF5B96F8),
                                        fontWeight: FontWeight.bold),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Material(
                                shadowColor: const Color.fromARGB(150, 0, 0, 0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                elevation: 10,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Color(0xFF5B96F8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter password';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 20.0, end: 20.0),
                                      child: Icon(Icons.key_rounded),
                                    ),
                                    prefixIconColor: Color(0xFF5B96F8),
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(50)),
                                    // ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 0, color: Color(0xFFF5F5F5)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFF5B96F8)),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Color(0xFF5B96F8),
                                        fontWeight: FontWeight.bold),
                                    alignLabelWithHint: false,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                ),
                              ),
                            ],
                          )),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const ForgotPassword()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF9E9E9E),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF306BCE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          User? user = await loginUsingEmail(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                          if (_formKey.currentState!.validate()) {
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Navigation()));
                            }
                            // ignore: empty_statements
                          }
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            backgroundColor: const Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async {
                            User? user = await signInWithGoogle();
                            print(user);
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Navigation()));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Image.asset("assets/logo/google.png"),
                              ),
                              Text(
                                'Continue with Google',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF404040),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),

                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, SlideTopRoute(page: const SignUp()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF2756A5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}

// Path: lib\auth\signup.dart
