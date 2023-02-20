// Sign In or Log in Page
// This page is used to sign in or log in to the app

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF2756A5)),
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Image.asset(
              // Import imgae from folder assets 
              'assets/illustration/login.png',
              height: 205,
              width: 400,
              alignment: Alignment.center,
            )
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Hello Again!',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Welcome back you’ve been missed',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              shadowColor: const Color.fromARGB(150, 0, 0, 0),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              elevation: 10,
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Padding(
                    padding:  EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                    child: Icon(Icons.mail),
                  ),
                  prefixIconColor: Color(0xFF5B96F8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide( width: 1, color: Color(0xFF5B96F8)),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Color(0xFF5B96F8),
                    fontWeight: FontWeight.bold
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding:  EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Icon(Icons.key_rounded),
                ),
                prefixIconColor: Color(0xFFC2C2C2),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(50)),
                // ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide( width: 0, color: Color(0xFFF5F5F5)),
                ),
                enabled: false,
                filled: true,
                fillColor: Color(0xFFF5F5F5),
                hintText: 'Password',
                contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
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
              onPressed: () {},
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
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child :Image.asset("assets/logo/google.png"),
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
              )
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {},
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
      ),
    );
  }
}

// Path: lib\auth\signup.dart
