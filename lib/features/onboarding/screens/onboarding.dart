import 'package:find_cook/common/widgets/custom_outlined_button.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/features/authentication/presentation/screens/signin.dart';
import 'package:find_cook/features/authentication/presentation/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/text_view.dart';
import '../../../core/theme/pallets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();

  bool lastpagechange = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  lastpagechange = (value == 2);
                  currentIndex = value;
                });
              },
              children: [
                ImageWidget(imageUrl: "assets/png/chef.jpg"),
                ImageWidget(imageUrl: "assets/png/chef5.jpg"),
                ImageWidget(imageUrl: "assets/png/chef3.jpg"),
              ],
            ),
            30.verticalSpace,
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  lastpagechange
                      ? SizedBox()
                      : SmoothPageIndicator(
                        effect: const ExpandingDotsEffect(
                          spacing: 8.0,
                          dotWidth: 10.0,
                          dotHeight: 6.0,
                          strokeWidth: 2,
                          dotColor: Pallets.grey75,
                          activeDotColor: Color(0xfffaab65),
                        ),
                        controller: _controller,
                        count: 3,
                      ),
                  20.verticalSpace,
                  lastpagechange
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomOutlinedButton(
                              child: TextView(
                                text: "Login",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (ctx) => SigninScreen(),
                                  ),
                                );
                              },
                            ),
                            // CustomButton(
                            //   padding:
                            //   EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            //   bgColor: Color(0xfffaab65),
                            //   // isExpanded: t,
                            //   onPressed: () {
                            //
                            //   },
                            //   child: const Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 10),
                            //     child: TextView(
                            //       text: "Login",
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            15.verticalSpace,
                            CustomButton(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 10,
                              ),
                              bgColor: Color(0xfffaab65),
                              // isExpanded: t,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (ctx) => SignupScreen(),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextView(
                                  text: "Register",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,

                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TextView(
                            //   text: "Skip",
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.w500,
                            //   onTap: (){
                            //     _controller.jumpToPage(currentIndex+2);
                            //   },
                            // ),
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                _controller.jumpToPage(currentIndex + 1);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xfffaab65),
                                child: Icon(
                                  Iconsax.arrow_right_1,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  40.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     ImageWidget(
      //       imageUrl: "assets/png/chef5.jpg",
      //       height: 1.sh,
      //       width: 1.sw,
      //     ),
      //   ],
      // ),
    );
  }
}
