import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/logout_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name;
  late String email;
  late String photoUrl = "";
  late bool emailVerified;
  late String uid;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      name = user.displayName.toString();
      email = user.email.toString();
      photoUrl = user.photoURL.toString();

      // Check if user's email is verified
      emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      uid = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            color: blueColor,
            iconSize: 30,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    child: CircleAvatar(
                      radius: 30,
                      foregroundImage:
                          // photoUrl.isEmpty ? const AssetImage('assets/illustration/student.png') : NetworkImage(photoUrl),
                          photoUrl == " "
                              ? const AssetImage(
                                      'assets/illustration/student.png')
                                  as ImageProvider
                              : NetworkImage(photoUrl),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        name.isEmpty ? 'No Name' : name,
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        email.isEmpty ? 'No Email' : email,
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Row(children: [
                    MaterialButton(
                      onPressed: () {},
                      minWidth: 140,
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [LogoutButton()])
            ],
          )
        ],
      ),
    );
  }
}
