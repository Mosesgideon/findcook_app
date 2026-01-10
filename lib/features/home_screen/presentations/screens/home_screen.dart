import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/error_widget.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/core/services/share_prefs/shared_prefs_save.dart';
import 'package:find_cook/core/theme/pallets.dart';
import 'package:find_cook/features/ai/ask_ai.dart';
import 'package:find_cook/features/home_screen/data/data/repository_impl.dart';
import 'package:find_cook/features/home_screen/presentations/bloc/cook_bloc.dart';
import 'package:find_cook/features/home_screen/presentations/screens/cook_details.dart';
import 'package:find_cook/features/home_screen/presentations/widgets/cook_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/text_view.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../widgets/non_cookwidget.dart';

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

  final List<String>items=["Total Bookings","Total Accepted","Total Completed","Total Pending","Total Cancelled"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: GlassmorphicContainer(
          width: 60,
          height: 60,
          borderRadius: 20,
          blur: 20,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.1),
                Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: [
                0.1,
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.5),
              Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child: Center(child: InkWell(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>AskAiScreen()));
              },
              child: ImageWidget(imageUrl: "assets/png/ai.png",
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>AskAiScreen()));

              },))),
        ),
      ),
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


                ImageWidget(
                  imageUrl: user?.profileImage??'',
                  width: 60,
                  height: 60,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Color(0xfffaab65),
                    width: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            user?.role=="Cook/Chef"?SizedBox():   Padding(
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
            user?.role=="Cook/Chef"?
            CookWidget()
            : NonCookwidget()
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
