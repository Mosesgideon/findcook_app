import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/features/feeds/presentations/screens/app_feeds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
class AppSettinggs extends StatefulWidget {
  const AppSettinggs({super.key});

  @override
  State<AppSettinggs> createState() => _AppSettinggsState();
}

class _AppSettinggsState extends State<AppSettinggs> {
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
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          // decoration: BoxDecoration(color: Color(0xfffaab65)),
          child: SafeArea(
            child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageWidget(
                  imageUrl: "assets/png/cook.jpg",
                  width: 50,
                  height: 50,
                  borderRadius: BorderRadius.circular(255),
                  border: Border.all(
                    color: Color(0xfffaab65),
                    width: 2,
                  ),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(text: user?.fullname??''),
                    4.verticalSpace,
                    TextView(text:  user?.email??'',fontSize: 10,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Divider(),
            20.verticalSpace,
            SettingsItem(widget: Icon(Iconsax.user,size: 20,), title: 'View Profile', ontap: () {  },),
            SettingsItem(widget: Icon(Iconsax.setting_2,size: 20,), title: 'Settings', ontap: () {  },),
            SettingsItem(widget: Icon(Icons.history,size: 20,), title: 'Subscriptions/Transactions', ontap: () {  },),
            Divider(),
            SettingsItem(widget: Icon(Icons.telegram_outlined,size: 20,), title: 'Invite Member', ontap: () {  },),
            SettingsItem(widget: Icon(Icons.headphones_outlined,size: 20,), title: 'Support', ontap: () {  },),
            SettingsItem(widget: Icon(Iconsax.people,size: 20,), title: 'Community', ontap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>AppFeeds()));
            },),
            Divider(),
            20.verticalSpace,
            SettingsItem(widget: Icon(Icons.logout_outlined,size: 20,), title: 'Logout', ontap: () {  },),

30.verticalSpace,
            CustomButton(
              isExpanded: false,
              child: TextView(text: "Delete Account",color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15,), onPressed: (){},bgColor: Colors.red,)
          ],
        ),
      ),

    );
  }
}


class SettingsItem extends StatefulWidget {
  final Widget widget;
  final String  title;
  final VoidCallback ontap;
  const SettingsItem({super.key, required this.widget, required this.title, required this.ontap});

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap:widget.ontap,
        child: Row(
          children: [
            widget.widget,
            15.horizontalSpace,
            TextView(text: widget.title,fontWeight: FontWeight.w500,fontSize: 15,),
          ],
        ),
      ),
    );
  }
}
