import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/error_widget.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/core/services/share_prefs/shared_prefs_save.dart';
import 'package:find_cook/features/home_screen/data/data/repository_impl.dart';
import 'package:find_cook/features/home_screen/presentations/bloc/cook_bloc.dart';
import 'package:find_cook/features/home_screen/presentations/screens/cook_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/text_view.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';

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

  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;
  final coobloc = CookBloc(AllCooksRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _loadUser();
    coobloc.add(GetCookEvent());
  }

  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(color: Color(0xfffaab65)),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.green),
                    SizedBox(width: 8),
                    TextView(text: user?.location.placeName ?? ''),
                  ],
                ),


                CircleAvatar(child: Icon(Iconsax.user)),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xfffaab65)),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.search_normal, size: 20),
                    10.horizontalSpace,
                    TextView(text: "Search for Cook", color: Colors.grey),
                  ],
                ),
              ),
            ),
            BlocConsumer<CookBloc, CookState>(
              bloc: coobloc,
              listener: _listenToetCookState,
              builder: (context, state) {
                if (state is CookFailuireSate) {
                  return Center(child: AppPromptWidget(onTap: (){coobloc.add(GetCookEvent());},));
                }
                if (state is CookSuccessSate) {
                  if (state.response.isEmpty) {
                    return SizedBox(
                      height: 1.sh,
                      width: 1.sw,
                      child: Center(
                        child: TextView(text: "No cooks available in your area"),
                      ),
                    );
                  }

                  final cook=state.response;
                  return Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        20.verticalSpace,
                        TextView(text: "${state.response.length.toString()} cooks around you"),
                        TextView(
                          text: "List of top rated cooks",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        20.verticalSpace,
                        Column(
                          children: List.generate(
                            cook.length,
                            (ctx) => Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: InkWell(
                                onTap: () {
                                  print("🎯 Tapped cook item at index: $ctx");
                                  print("🔍 Cook ID from list: ${cook[ctx].cookID}");
                                  print("🔍 Cook ID toString: ${cook[ctx].cookID.toString()}");
                                  print("🔍 Cook Name: ${cook[ctx].cookName}");
                                  print("🔍 Full cook object: ${cook[ctx]}");
                                  print(cook[ctx].cookID.toString());
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (ctxNav) => CookDetails(response: state.response, cookName: cook[ctx].cookName, cookEmail: cook[ctx].cookEmail, cookAbout: cook[ctx].cookAbout, cookLocation:  cook[ctx].cookLocation, yearsOfExperience:  cook[ctx].yearsOfExperience, cookType:  cook[ctx].cookType, cookChargePerHr:  cook[ctx].cookChargePerHr, marriageStatus:  cook[ctx].marriageStatus, cookLanguages:  cook[ctx].cookLanguages, cookUsername:  cook[ctx].cookUsername
                                          , cookReligion:  cook[ctx].cookReligion, cookPhone:  cook[ctx].cookPhone, cookProfileImage:  cook[ctx].cookProfileImage, cookCoverImage:  cook[ctx].cookCoverImage, cookHouseAddress:  cook[ctx].cookHouseAddress, cookGallery:  cook[ctx].cookGallery, cookServices:  cook[ctx].cookServices, cookSpecialMeals:  cook[ctx].cookSpecialMeals, ratings:  cook[ctx].ratings, cookID: cook[ctx].cookID.toString(), docID: cook[ctx].docID.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 1.sw,
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Image.asset("assets/png/cook.jpg",),
                                      Stack(
                                        children: [
                                          ImageWidget(
                                            imageUrl: cook[ctx].cookCoverImage,
                                            width: 1.sw,
                                            height: 160,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (ctxNav) => CookDetails(response: state.response, cookName: cook[ctx].cookName, cookEmail: cook[ctx].cookEmail, cookAbout: cook[ctx].cookAbout, cookLocation:  cook[ctx].cookLocation, yearsOfExperience:  cook[ctx].yearsOfExperience, cookType:  cook[ctx].cookType, cookChargePerHr:  cook[ctx].cookChargePerHr, marriageStatus:  cook[ctx].marriageStatus, cookLanguages:  cook[ctx].cookLanguages, cookUsername:  cook[ctx].cookUsername
                                                      , cookReligion:  cook[ctx].cookReligion, cookPhone:  cook[ctx].cookPhone, cookProfileImage:  cook[ctx].cookProfileImage, cookCoverImage:  cook[ctx].cookCoverImage, cookHouseAddress:  cook[ctx].cookHouseAddress, cookGallery:  cook[ctx].cookGallery, cookServices:  cook[ctx].cookServices, cookSpecialMeals:  cook[ctx].cookSpecialMeals, ratings:  cook[ctx].ratings,cookID: cook[ctx].cookID.toString(),
                                                    docID: cook[ctx].docID.toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Positioned(
                                            bottom: 1,
                                            right: 1,
                                            child: Container(
                                              width: 60,
                                              padding: EdgeInsets.all(4),

                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                  4,
                                                ),
                                                color: Colors.white.withOpacity(
                                                  0.3,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextView(
                                                    text: cook[ctx].ratings.length.toString(),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  Icon(
                                                    Iconsax.star1,
                                                    color: Color(0xfffaab65),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextView(text: cook[ctx].cookName.toString()),
                                                TextView(
                                                  text: cook[ctx].marriageStatus,
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                            TextView(
                                              text: cook[ctx].cookLocation,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            TextView(
                                              text:
                                                  "${cook[ctx].yearsOfExperience}+ years experience of home cooking",
                                              color: Colors.black54,
                                              fontSize: 12,
                                            ),
                                            4.verticalSpace,
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1.sw,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xfffaab65),
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextView(
                                                text: "\$${cook[ctx].cookChargePerHr}/hr",
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        70.verticalSpace,
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _listenToetCookState(BuildContext context, CookState state) {
    if (state is CookLoadingSate) {
      CustomDialogs.showLoading(context);
    }
    if (state is CookFailuireSate) {
      // context.pop();
      Navigator.pop(context);
      print(state.error);
    }
    if (state is CookSuccessSate) {
      Navigator.pop(context);
      print(state.response.length);
      print(state.response.first.role);
      print(state.response.first.cookID.toString());
    }
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
