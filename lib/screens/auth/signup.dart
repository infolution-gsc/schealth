// Sign In or Log in Page
// This page is used to sign in or log in to the app

// ignore_for_file: depend_on_referenced_packages, unused_import, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_planner/screens/dashboard.dart';
import 'package:healthy_planner/widget/navigation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordVisible=false;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _confirmPasswordController;


  @override
  void initState(){
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    passwordVisible=true;
  }  
  bool isEnable = false;

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

  final _formKey = GlobalKey<FormState>();

  bool selectedName = false;
  bool selectedEmail = false;
  bool selectedConfirm = false;
  bool selectedPass = false;
  bool fillName = false;
  bool fillEmail = false;
  bool fillPass = false;
  bool fillConfirm = false;

  @override
  Widget build(BuildContext context) {
    // Text field controller
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF2756A5)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      // Import imgae from folder assets
                      'assets/illustration/signup.png',
                      height: 170,
                      width: 226,
                      alignment: Alignment.center,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Let’s Get Started!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create an Account to Avail All Features',
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
                      // shadowColor: const Color.fromARGB(150, 0, 0, 0),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      elevation: 0,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Color(0xFF5B96F8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: fillName ? const Color.fromARGB(0, 0, 0, 0): const Color(0xFFF5F5F5),
                          prefixIcon: const Padding(
                            padding:  EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                            child: Icon(Icons.tag_faces),
                          ),
                          prefixIconColor: selectedName ? const Color(0xFF5B96F8) : const Color(0xFFC2C2C2),
                          enabledBorder: const  OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 0, color: Color(0xFFF5F5F5)),
                            ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 1, color: Color(0xFF5B96F8)),
                            ),
                          hintText: 'Name',
                          hintStyle: const TextStyle(
                            color: Color(0xFFC2C2C2),
                            fontWeight: FontWeight.bold
                          ),
                          focusColor: const Color(0xFF5B96F8),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,

                        style: const TextStyle(
                          color: Color(0xFF5B96F8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fillEmail ? const Color.fromARGB(0, 0, 0, 0): const Color(0xFFF5F5F5),
                          prefixIcon: const Padding(
                            padding:  EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                            child: Icon(Icons.mail),
                          ),
                          prefixIconColor: selectedEmail ? const Color(0xFF5B96F8) : const Color(0xFFC2C2C2),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 1, color: Color(0xFF5B96F8)),
                            ),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 0, color: Color(0xFFF5F5F5)),
                            ),
                          hintText: 'Email',
                          hintStyle:const TextStyle(
                            color: Color(0xFFC2C2C2),
                            fontWeight: FontWeight.bold
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,

                        obscureText: passwordVisible,
                        style: const TextStyle(
                          color: Color(0xFF5B96F8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                        ),
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        // onTap: () {
                        //   setState(() {
                        //     selectedPass = true;
                        //   });                        },
                        // // onEditingComplete: () {
                        // //   onButtonTap(false);
                        // // },
                        // onTapOutside: (event) {
                        //   setState(() {
                        //     selectedPass = false;
                        //   });
                        // },
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding:  EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                            child: Icon(Icons.key_rounded),
                          ),
                          filled: true,
                          fillColor: fillPass ? const Color.fromARGB(0, 0, 0, 0): const Color(0xFFF5F5F5),
                          prefixIconColor: selectedPass ? const Color(0xFF5B96F8) : const Color(0xFFC2C2C2),
                          suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                                ),
                              onPressed: () {
                                // text is not show when press

                                setState(() {
                                    passwordVisible = !passwordVisible;
                                });
                              },
                              ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 1, color: Color(0xFF5B96F8)),
                            ),
                          enabledBorder: const  OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 0, color: Color(0xFFF5F5F5)),
                            ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Color(0xFFC2C2C2),
                            fontWeight: FontWeight.bold
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: TextFormField(
                          textInputAction: TextInputAction.done,

                          style: const TextStyle(
                            color: Color(0xFF5B96F8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                          ),
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: passwordVisible,
                        //   onTap: () {
                        //   setState(() {
                        //     selectedConfirm = true;
                        //   });                        },
                        // // onEditingComplete: () {
                        // //   onButtonTap(false);
                        // // },
                        // onTapOutside: (event) {
                        //   setState(() {
                        //     selectedConfirm = false;
                        //   });
                        // },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: fillConfirm ? const Color.fromARGB(0, 0, 0, 0): const Color(0xFFF5F5F5),
                            prefixIcon: const  Padding(
                              padding:   EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                              child: Icon(Icons.key_rounded)
                            ),
                            prefixIconColor: selectedConfirm ? const Color(0xFF5B96F8) : const Color(0xFFC2C2C2),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                                ),
                              onPressed: () {
                                // text is not show when press

                                setState(() {
                                    passwordVisible = !passwordVisible;
                                });
                              },
                              ),
                            focusColor: const Color(0xFFF5F5F5),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 1, color: Color(0xFF5B96F8)),
                            ),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(50)),
                            // ),
                            enabledBorder: const  OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide( width: 0, color: Color(0xFFF5F5F5)),
                            ),
                            // enabledBorder:  OutlineInputBorder(
                            //     borderRadius: BorderRadius.all(Radius.circular(50)),
                            //     borderSide: BorderSide( width: 1, color: Color(0xFF5B96F8)),
                            //   ),
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(
                              color: Color(0xFFC2C2C2),
                              fontWeight: FontWeight.bold
                            ),
                            contentPadding: const  EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                        ),
                    ),
                ],)
              ),
                const SizedBox(
                  height: 20,
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
                    User? user = await loginUsingEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                    print(user);
                    if (_formKey.currentState!.validate()) {
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                      }
                      // ignore: empty_statements
                    };
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have an Account?'),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
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
    );
  }
}

// Path: lib\auth\signup.dart
