import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/outlined_form_field.dart';
import 'package:find_cook/features/feeds/presentations/screens/feedimage.dart';
import 'package:find_cook/features/feeds/presentations/screens/postscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../../core/theme/pallets.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import 'feedvideo.dart';

class AppFeeds extends StatefulWidget {

  const AppFeeds({super.key, });

  @override
  State<AppFeeds> createState() => _AppFeedsState();
}

class _AppFeedsState extends State<AppFeeds> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(

          toolbarHeight: 10,
          bottom: TabBar(
            padding: EdgeInsets.only(left: 10,right: 10),
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateColor.transparent,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 2),
            labelPadding: EdgeInsets.all(10),
            labelColor: Colors.white,
            // unselectedLabelStyle: TextStyle(color: ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:BoxDecoration(
              color: Color(0xfffaab65),
              borderRadius: BorderRadius.circular(20),
              
            ),
              tabs: [
            TextView(text: "Feeds"),
            TextView(text: "Videos"),
          ]),
        ),
        body:TabBarView(children: [
          Feedimage(),
          Feedvideo(),
        ]),
        // floatingActionButtonLocation: ,
        floatingActionButton:user?.role=="Cook/Chef"? Padding(
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
                Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>Postscreen()));
              },
                child: Icon(Iconsax.add,size: 30,color: Color(0xfffaab65),))),
          ),
        ):SizedBox(),


      ),

    );
  }
}



class CommentBottomSheet extends StatefulWidget {

  final String commenterName;
  final String posterName;
  final String commenterID;
  final String postID;
  final String posterID;
  const CommentBottomSheet({super.key, required this.commenterName, required this.commenterID, required this.postID, required this.posterName, required this.posterID});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final controller=TextEditingController();
  final store=FirebaseFirestore.instance.collection("feedImageComment");
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),
        ),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
       Column(
         children: [
           TextView(text: "Comment on ${widget.posterName} Post",fontWeight: FontWeight.w500,),
           20.verticalSpace,

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder<QuerySnapshot>(
              stream: store
                .where("postID", isEqualTo: widget.postID)

                .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasError){
                  print(snapshot.error);
                  return Center(child:
                    Container(
                      width: 1.sw,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.orange)),
                    child: TextView(text: "Try Again",onTap: (){
                      store
                          .where("postID", isEqualTo: widget.postID)
                          .orderBy("commentDate", descending: true)
                          .snapshots();
                    },),)

                    ,);
                }
                if(snapshot.hasData){
                  if(snapshot.data!.docs.isEmpty){

                    return Column(
                      children: [
                        Icon(Iconsax.book_1),
                        4.verticalSpace,
                        TextView(text: "No comments"),
                      ],
                    );
                  }
                  final comments = snapshot.data!.docs;
                  return Column(
                    children: List.generate(comments.length, (ctx){
                      final comment = comments[ctx];
                      final data = comment.data() as Map<String, dynamic>;

                      final name = data["commenterName"] ?? "Anonymous";
                      final text = data["comment"] ?? "";
                      final date = (data["commentDate"] as Timestamp?)?.toDate();

                      final formattedDate = date != null
                          ? "${date.day}-${date.month}-${date.year}"
                          : "";
                      return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.08)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(text:  data["commenterName"] , fontSize: 12,),
                            Row(

                              children: [
                                TextView(
                                  text: data["comment"] ,
                                  fontSize: 14,),
                                10.horizontalSpace,
                                TextView(text: formattedDate, fontSize: 10,),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                    }),
                  );
                }

             return SizedBox();
              }
            ),
          ),
           20.verticalSpace,
         ],
       ),


          OutlinedFormField(hint: "comment....",controller: controller,suffix: InkWell(
              splashColor: Colors.transparent,
              onTap: (){
               sendComment(controller.text.trim());

              },
              child: Icon(Iconsax.send_1,color: Pallets.orange,)),)
        ],
      ),

    );
  }

  void sendComment(String comment,) {
    final store=FirebaseFirestore.instance.collection("feedImageComment");
    if(controller.text.isNotEmpty){
      store.add({
        "comment":comment,
        "commenterName":widget.commenterName,
        "commenterID":widget.commenterID,
        "postID":widget.postID,
        "commentDate":Timestamp.now(),
      });

      controller.clear();


    }
  }
}
