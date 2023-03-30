import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:healthy_planner/screens/start/fisrt.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/transitions/slide_transitions.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/bg/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Image(
                            width: MediaQuery.of(context).size.width,
                            image: const AssetImage(
                                'assets/illustration/letsstart.png')),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Schealth",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 36,
                                  color: blueBackground),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: const Text(
                                "Be organized, stay focused, and stay healthy",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xFF404040)),
                              ))
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFF9CC0FB),
                                  blurRadius: 12,
                                  offset: Offset(0, 5))
                            ]),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xFF9CC0FB)),
                              backgroundColor:
                                  MaterialStateProperty.all(blueBackground),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ))),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                SlideLeftRoute(page: const FirstStart()));
                          },
                          child: Text(
                            "Let's Start",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
