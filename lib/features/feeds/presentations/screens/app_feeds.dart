import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/outlined_form_field.dart';
import 'package:find_cook/features/feeds/presentations/screens/feedimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import 'feedvideo.dart';

class AppFeeds extends StatefulWidget {
  const AppFeeds({super.key});

  @override
  State<AppFeeds> createState() => _AppFeedsState();
}

class _AppFeedsState extends State<AppFeeds> {
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
        ])
      ),
    );
  }
}



class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(text: "Lisa Panchal Jani Posts Comments...",fontWeight: FontWeight.w500,),
          20.verticalSpace,

          ...List.generate(4, (ctx)=>Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(text: "Luke Dude",fontSize: 13,),
                  Row(

                    children: [
                      TextView(text: "Nice meal,I will book you again",fontSize: 8,),
                      10.horizontalSpace,
                      TextView(text: "10-12-2025",fontSize: 10,),
                    ],
                  )
                ],
              ),
            ),
          )),
          20.verticalSpace,
          OutlinedFormField(hint: "comment....")
        ],
      ),
    );
  }
}
