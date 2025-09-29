import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/features/home_screen/presentations/screens/cook_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/text_view.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _listController = ScrollController();
  //
  // void scrollListenerController() {
  //   setState(() {});
  // }
  //
  // @override
  // void initState() {
  //
  //   _listController.addListener(scrollListenerController);
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _listController.removeListener(scrollListenerController);
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, 100), child: Container(
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
                  TextView(text: "Lagos, Nigeria"),
                ],
              ),
              CircleAvatar(child: Icon(Iconsax.user))
            ],
          ),
        ),
      )
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18,right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15
                  ),
                  border: Border.all(
                    color: Color(0xfffaab65)
                  )
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.search_normal,size: 20,),
                    10.horizontalSpace,
                    TextView(text: "Search for Cook",color: Colors.grey,),
                  ],
                ),
              ),
              20.verticalSpace,
              TextView(text: "20 cooks around you"),
              TextView(text: "List of top rated cooks",fontSize: 12,color: Colors.grey,),
              20.verticalSpace,
              Column(
                children: List.generate(4, (ctx)=>Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>CookDetails()));
                    },
                    child: Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                        boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1)
                        )]
                    )
                      ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.asset("assets/png/cook.jpg",),
                          Stack(
                            children:[
                              ImageWidget(imageUrl: "assets/png/cook.jpg",
                                width: 1.sw,height: 160,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15,),topRight: Radius.circular(15),
                                ),
                                onTap: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>CookDetails()));

                                }
                                ,
                              ),
                              Positioned(
                                bottom: 1,right: 1,
                                child: Container(
                                  width: 60,
                                  padding: EdgeInsets.all(4),

                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                  color: Colors.white.withOpacity(0.3)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextView(text: "4.5",color: Colors.white,fontWeight: FontWeight.w700,),
                                      Icon(Iconsax.star1,color: Color(0xfffaab65),)
                                    ],
                                  ),
                                ),
                              )

                            ]  ),
                          10.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextView(text: "Lisa Panchal Jani"),
                                    TextView(text: "Married",color: Colors.black54,fontSize: 12,),
                                  ],
                                ),
                                TextView(text: "Nekede,Owerri West,Nigeria",color: Colors.grey,fontSize: 12,),
                                TextView(text: "3+ years experience of home cooking",color: Colors.black54,fontSize: 12,),
                                4.verticalSpace,



                              ],
                            ),
                          ),
                          Container(

                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            decoration: BoxDecoration(
                              color: Color(0xfffaab65),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                TextView(text: "Personal/Private chef",color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600,),
                                TextView(text: "\$10/hr",color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600,),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              ),
              70.verticalSpace,
            ],
          ),
        ),
      ),



    );
  }
}
// body:  NestedScrollView(
//     controller: _listController,
//     floatHeaderSlivers: true,
//     physics: const BouncingScrollPhysics(),
//     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//       // double opacity=0;
//       // if(opacity>1.0) opacity=1;
//       // if(opacity<0.0) opacity=0;
//       return [
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8),
//             child: SizedBox(
//               height: 150,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Color(0xfffaad65)
//                         ),
//                       )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ];
//     },body: SizedBox()),