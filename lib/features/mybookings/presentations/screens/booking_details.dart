import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../core/theme/pallets.dart';
import '../../../home_screen/presentations/widgets/bookbottomsheet.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Booking Details",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        actions: [Icon(Iconsax.call), 20.horizontalSpace],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xfffaab65),
        child: Icon(Icons.message, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "Personal Details",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),10.verticalSpace,
                   Container(
                padding: EdgeInsets.all(15),
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     blurRadius: 0.5,
                  //     spreadRadius: 0.5,
                  //     offset: Offset(0.5, 0.5),
                  //   ),
                  // ],
                ),
                child: Row(
                  children: [
                    ImageWidget(imageUrl: "assets/png/cook.jpg",
                      width:100,height: 100,
                      borderRadius: BorderRadius.circular(50),border: Border.all(color: Color(0xfffaab65),width: 2),),
                    10.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        8.verticalSpace,
                        TextView(
                          text: "Lisa Panchal Jani",
                          fontSize: 12,
                        ),
                        4.verticalSpace,
                        TextView(
                          text: "Nekede,Owerri West,Nigeria",
                          fontSize: 12,
                        ),
                        4.verticalSpace,
                        TextView(
                          text: "English,Spanish,Igbo,Yoruba",
                          fontSize: 12,
                        ),
                        4.verticalSpace,
                        TextView(text: "+234(0)7042973460", fontSize: 12),
                      ],
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              TextView(text: "Booked For : ",fontSize: 15,fontWeight: FontWeight.w500,),
              10.verticalSpace,
              TextView(text: "Personal/Private Chef ",fontWeight: FontWeight.w400,),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Date Booked :  ",fontWeight: FontWeight.w400,),
                  TextView(text: "20 Sept 2025",fontWeight: FontWeight.w400,),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Event Status :  ",fontWeight: FontWeight.w400,),
                  TextView(text: "Completed",fontWeight: FontWeight.w400,color: Colors.green,),
                ],
              ), 10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Amount Paid :  ",fontWeight: FontWeight.w400,),
                  TextView(text: "\$300",fontWeight: FontWeight.w700,),
                ],
              ),
        20.verticalSpace,
              TextView(text: "Booking Proposal",fontWeight: FontWeight.w500,),
              5.verticalSpace,
              TextView(text: "An experienced cook is a professional who expertly prepares dishes according to recipes, possesses strong knowledge of various cooking techniques and food safety, and efficiently manages a fast-paced kitchen environment to ensure quality, consistency, and presentation.",fontWeight: FontWeight.w300,fontSize: 12,),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Proposal Status :  ",fontWeight: FontWeight.w400,),
                  TextView(text: "Accepted",fontWeight: FontWeight.w400,color: Colors.green,),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Date Accepted : ",),
                  TextView(text: "20 Sept 2025",fontWeight: FontWeight.w400,color: Colors.green,),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Contract/Booking Duration: ",),
                  TextView(text: "4 days ",fontWeight: FontWeight.w400,),
                ],
              ),
              20.verticalSpace,
              TextView(text: "Dishes Selected",fontWeight: FontWeight.w500,),
              5.verticalSpace,
              Wrap(
                crossAxisAlignment:WrapCrossAlignment.start ,
                runAlignment: WrapAlignment.spaceAround,
                spacing: 4,
                runSpacing: 8,
                children: List.generate(5, (ctx)=>Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Pallets.grey60.withOpacity(0.1))

                  ),
                  child: TextView(text: "Jellof rice"),

                )),

              ),

              20.verticalSpace,

                  TextView(text: "Start And End Date: ",),5.verticalSpace,
                  TextView(text: "20 Sept 2025 - 24 Sept 2025 ",fontWeight: FontWeight.w400,),
20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(child: TextView(text: "Book Again",color: Colors.white,fontWeight: FontWeight.w700,), onPressed: (){
                  CustomDialogs.showBottomSheet(context, Bookbottomsheet());
                }),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
