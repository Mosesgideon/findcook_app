import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import 'app_feeds.dart';
class Feedvideo extends StatefulWidget {
  const Feedvideo({super.key});

  @override
  State<Feedvideo> createState() => _FeedvideoState();
}

class _FeedvideoState extends State<Feedvideo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: List.generate(
              10,
                  (ctx) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ImageWidget(
                          imageUrl: "assets/png/cook.jpg",
                          width: 40,
                          height: 40,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xfffaab65),
                            width: 2,
                          ),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: "Lisa Panchal Jani",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            TextView(
                              text: "Owerri , Nigeria",
                              fontWeight: FontWeight.w300,
                              fontSize: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children:[
                        ImageWidget(
                        imageUrl: "assets/png/cook.jpg",
                        width: 1.sw,
                        height: 200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xfffaab65), width: 1),
                      ),
                        Center(
                          child: Icon(Icons.play_arrow_outlined,color: Colors.white,size: 35,),
                        ),
                      ]

                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border),
                            4.horizontalSpace,
                            TextView(text: "10", fontSize: 10),
                          ],
                        ),
                        30.horizontalSpace,
                        InkWell(
                          onTap: (){
                            CustomDialogs.showBottomSheet(context, CommentBottomSheet());
                          },
                          child: Row(
                            children: [
                              Icon(Iconsax.message),
                              4.horizontalSpace,
                              TextView(text: "10", fontSize: 10),
                            ],
                          ),
                        ),
                        30.horizontalSpace,
                        Icon(
                          Icons.share,
                          color: Colors.black87.withOpacity(0.6),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    TextView(
                      text:
                      "They are adept at ingredient preparation, equipment operation, maintaining cleanliness, and collaborating with other staff to deliver appealing and safe meals while potentially mentoring junior team members",
                      fontSize: 10,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
