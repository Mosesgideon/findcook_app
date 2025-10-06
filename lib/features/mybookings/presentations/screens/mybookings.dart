import 'package:find_cook/common/widgets/circular_loader.dart';
import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/mybookings/presentations/screens/booking_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
class Mybookings extends StatefulWidget {
  const Mybookings({super.key});

  @override
  State<Mybookings> createState() => _MybookingsState();
}

class _MybookingsState extends State<Mybookings> {
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, 100),
          child: Container(
        padding: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
        decoration: BoxDecoration(color: Color(0xfffaab65)),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.green),
                  SizedBox(width: 8),
                  TextView(text: user?.location.placeName??''),
                ],
              ),
              CircleAvatar(child: Icon(Iconsax.user))
            ],
          ),
        ),
      )
      ),
      body: SingleChildScrollView(
        child
            : Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(text: "Recent Bookings"),
              20.verticalSpace,
              Column(
                children: List.generate(6, (bookingCTX)=>Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>BookingDetails()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(1, 0)
                          )]
                      ),
                      child: Row(
                        children: [
                          ImageWidget(imageUrl: "assets/png/cook.jpg",
                            width:100,height: 100,
                            borderRadius: BorderRadius.circular(15),),

                          10.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextView(text: "Lisa Panchal Jani"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextView(text: "4.5",fontWeight: FontWeight.w500,color: Colors.black54,),
                                        Icon(Iconsax.star1,color: Color(0xfffaab65),)
                                      ],
                                    ),
                                  ],
                                ),
                                TextView(text: "Booked for 2 days",fontSize: 12,color: Colors.black.withOpacity(0.7),),
                                TextView(text: "Last booked 2 months ago",color: Colors.black54,fontSize: 12,),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextView(text: "Status : ",color: Colors.grey,fontSize: 12,),
                                    TextView(text: "Completed",color: Colors.green,fontSize: 12,fontWeight: FontWeight.w700,),
                                  ],
                                ),
                                // TextView(text: "3+ years experience of home cooking",color: Colors.black54,fontSize: 12,),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ),
              50.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
