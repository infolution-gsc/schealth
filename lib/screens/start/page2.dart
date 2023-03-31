import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Text(
                              "Manage Your Duty",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: const Text(
                                "Track your progress toward\ngoals and achieve them faster",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ))
                        ],
                      ),
                      Container(
                        child: Image(
                            width: MediaQuery.of(context).size.width,
                            image: const AssetImage(
                                'assets/illustration/secondpage.png')),
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
