import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/mybookings/data/models/book_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../core/theme/pallets.dart';
import '../../../home_screen/presentations/widgets/bookbottomsheet.dart';

class BookingDetails extends StatefulWidget {
  final AppBookingResponse reponse;
  const BookingDetails({super.key, required this.reponse});

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
        onPressed: () {
        widget.reponse.status=="pending"?  CustomDialogs.showToast("Messages are only available for accepted offer"):SizedBox();
        },
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
                    ImageWidget(imageUrl: widget.reponse.cookProfileImage??'',
                      width:100,height: 100,
                      borderRadius: BorderRadius.circular(50),border: Border.all(color: Color(0xfffaab65),width: 2),),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          8.verticalSpace,
                          TextView(
                            text: widget.reponse.cookName??'',
                            fontSize: 12,
                          ),
                          4.verticalSpace,
                          TextView(
                            text: "${widget.reponse.clientLocation??''} (${widget.reponse.cookHouseAddress??''}) ",
                            fontSize: 12,
                          ),
                          4.verticalSpace,
                          TextView(
                            text: widget.reponse.cookLanguages.toString(),
                            fontSize: 12,
                          ),
                          4.verticalSpace,
                          TextView(text:widget.reponse.cookPhone??'', fontSize: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              TextView(text: "Booked For : ",fontSize: 15,fontWeight: FontWeight.w500,),
              10.verticalSpace,
              TextView(text: widget.reponse.clientSelectedServices.toString(),fontWeight: FontWeight.w400,),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Date Booked :  ",fontWeight: FontWeight.w400,),
                  TextView(text: DateFormat('MMM d, yyyy').format(widget.reponse.bookedTime!),fontWeight: FontWeight.w400,),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Event Status :  ",fontWeight: FontWeight.w400,),
                  TextView(text: widget.reponse.status??'',fontWeight: FontWeight.w400,color: Colors.green,),
                ],
              ), 10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Consultation Fee"  ,fontWeight: FontWeight.w400,),
                  TextView(text: "\$20",fontWeight: FontWeight.w700,),
                ],
              ),
        20.verticalSpace,
              TextView(text: "Booking Proposal",fontWeight: FontWeight.w500,),
              5.verticalSpace,
              TextView(text: widget.reponse.notes??'',fontWeight: FontWeight.w300,fontSize: 12,),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Proposal Status :  ",fontWeight: FontWeight.w400,),
                  TextView(text: widget.reponse.status??'',fontWeight: FontWeight.w400,color: Colors.green,),
                ],
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(text: "Date Accepted : ",),
                  TextView(text: "Not yet accepted",fontWeight: FontWeight.w400,color: Colors.green,),
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
                children: List.generate(widget.reponse.clientSelectedSpecialMeals.length, (ctx)=>Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Pallets.grey60.withOpacity(0.1))

                  ),
                  child: TextView(text:widget.reponse.clientSelectedSpecialMeals[ctx]),

                )),

              ),

              20.verticalSpace,

                  TextView(text: "Start And End Date: ",),5.verticalSpace,
                  widget.reponse.status=="pending"?TextView(text: "Booking still pending",color: Pallets.grey35,):
                  TextView(text: "Not Yet accepted - 24 Sept 2025 ",fontWeight: FontWeight.w400,),
20.verticalSpace,
              widget.reponse.status=="pending"?SizedBox() :Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(child: TextView(text: "Book Again",color: Colors.white,fontWeight: FontWeight.w700,), onPressed: (){

                  // CustomDialogs.showBottomSheet(context,
                  // Bookbottomsheet(cookServices: [], cookSpecialMeals: [],));

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
