import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../dash_board/screens/base_page.dart';
class EnableLocationScreen extends StatefulWidget {
  const EnableLocationScreen({super.key});

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ImageWidget( imageUrl:"assets/png/location.png",size: 200,),
                10.verticalSpace,
                TextView(text: "For Technical reasons,Cook App will need access to you location,for better and smarter experience",align: TextAlign.center,fontSize: 12,),
              ],
            ))),

            CustomButton(child: TextView(text: "Allow Access",
              color: Colors.white,
              fontWeight: FontWeight.w600,
                ), onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>BasePage()));

            }),
            20.verticalSpace
          ],
        ),
      ),

    );
  }
}
