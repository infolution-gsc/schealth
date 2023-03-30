import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:healthy_planner/screens/auth/signin.dart';
import 'package:healthy_planner/screens/start/page1.dart';
import 'package:healthy_planner/screens/start/page2.dart';
import 'package:healthy_planner/screens/start/page3.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/transitions/slide_transitions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstStart extends StatefulWidget {
  const FirstStart({super.key});

  @override
  State<FirstStart> createState() => _FirstStartState();
}

class _FirstStartState extends State<FirstStart> {
  PageController _controller = PageController();
  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: IconButton(
              onPressed: () {
                _controller.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              icon: Icon(
                Icons.arrow_back,
                color: blueBackground,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text("Skip",
                      style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w600,
                          fontSize: 16))),
            ),
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  lastPage = (index == 2);
                });
              },
              children: const [
                PageOne(),
                PageTwo(),
                PageThree(),
              ],
            ),
            Container(
                alignment: const Alignment(0, 0.75),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: ScrollingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: blueBackground,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 8.0,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: blueBackground,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: blueBackground.withOpacity(0.5),
                                blurRadius: 12,
                                offset: const Offset(0, 5))
                          ]),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          lastPage != true
                              ? _controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn)
                              : Navigator.pushReplacement(context,
                                  SlideLeftRoute(page: const SignIn()));
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
