import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/core/theme/pallets.dart';
import 'package:find_cook/features/home_screen/presentations/widgets/bookbottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/image_widget.dart';

class CookDetails extends StatefulWidget {
  const CookDetails({super.key});

  @override
  State<CookDetails> createState() => _CookDetailsState();
}

class _CookDetailsState extends State<CookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Lisa Panchal Jani Profile",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ImageWidget(
                        imageUrl: "assets/png/cook.jpg",
                        width: 1.sw,
                        height: 160,
                      ),
                      Positioned(
                        bottom: 20,

                        left: 2,
                        right: 2,
                        child: Column(
                          children: [
                            ImageWidget(
                              imageUrl: "assets/png/cook.jpg",
                              width: 80,
                              height: 80,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Color(0xfffaab65)),
                            ),
                            10.verticalSpace,
                            Positioned(
                              bottom: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      TextView(
                                        text: "Lisa Panchal Jani",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TextView(
                                        text: "Nekede,Owerri West,Nigeria",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextView(text: "Verified"),
                                          4.horizontalSpace,
                                          Icon(
                                            Icons.verified_user_rounded,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "About Lisa Panchal Jani",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  5.verticalSpace,
                  TextView(
                    text:
                        "An experienced cook is a professional who expertly prepares dishes according to recipes, possesses strong knowledge of various cooking techniques and food safety, and efficiently manages a fast-paced kitchen environment to ensure quality, consistency, and presentation",
                    fontSize: 12,
                  ),20.verticalSpace,
                  TextView(
                    text: "Personal Details",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  8.verticalSpace,
                  TextView(text: "Location : Nekede,Owerri West,Nigeria",fontSize: 12,),
                  4.verticalSpace,
                  TextView(text: "Langguage : English,Spanish,Igbo,Yoruba",fontSize: 12,),
                  4.verticalSpace,

                  TextView(text: "Religion : Christianity",fontSize: 12,),
                  20.verticalSpace,
                  TextView(
                    text: "Specialties",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  10.verticalSpace,
                  Wrap(
                    crossAxisAlignment:WrapCrossAlignment.start ,
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 4,

                    runSpacing: 8,
                    children: List.generate(5, (ctx)=>Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Pallets.grey35.withOpacity(0.3))

                      ),
                      child: TextView(text: "Jellof rice"),

                    )),

                  ),
                  20.verticalSpace,
                  TextView(
                    text: "Services",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  10.verticalSpace,
                  Wrap(
                    crossAxisAlignment:WrapCrossAlignment.start ,
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 4,

                    runSpacing: 8,
                    children: List.generate(5, (ctx)=>Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Pallets.grey35.withOpacity(0.3))
                      ),
                      child: TextView(text: "Personal cook/chef"),

                    )),

                  ),
                  20.verticalSpace,
                  TextView(
                    text: "Gallery And Videos",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  15.verticalSpace,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:List.generate(4, (gallery)=> Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ImageWidget(imageUrl: "assets/png/cook.jpg",
                          width:100,height: 100,
                          borderRadius: BorderRadius.circular(15),),
                      ),)),
                  ),


                  20.verticalSpace,
                  TextView(text: "Rating And Reviews",fontSize: 16,fontWeight: FontWeight.w500,),
                  4.verticalSpace,
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Colors.yellow.withOpacity(0.05),
                            border: Border.all(color: Colors.yellow)),
                        child: TextView(text:"4/5",color: CupertinoColors.systemYellow,fontSize: 12,),),
                      4.horizontalSpace,
                      TextView(text: "(4 rating)",fontSize: 10,),

                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              5.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child:     RatingBarIndicator(
                                      rating: 3 ?? 0.0,
                                      itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                                      itemCount: 5,
                                      itemSize: 16.0,
                                      unratedColor: Pallets.grey90,
                                    ),
                                  ),
                                  TextView(
                                    text: '20/12/2025',
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                              5.verticalSpace,
                              TextView(
                                text: "She's the best ever seen cook",
                                fontSize: 12,
                              ),
                              5.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(text: "by Moses Gideon",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.verified,color: Colors.green,size: 14,),
                                      TextView(text: "Verified User",fontSize: 10,color: Colors.green,),
                                    ],
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextView(text: "Note:You need to book the cook in order to contact or chat them",fontSize: 10,),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 50),
              child: CustomButton(child: TextView(text: "Book Cook",color: Colors.white,fontWeight: FontWeight.w700,), onPressed: (){
                CustomDialogs.showBottomSheet(context, Bookbottomsheet());
              }),
            )
          ],
        ),
      ),
    );
  }
}
