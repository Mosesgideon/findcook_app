import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/location/data/models/location_payload.dart';
import 'package:find_cook/features/onboarding/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cook_onboarding/presentations/screens/onboarding_1.dart';
import '../../../dash_board/screens/base_page.dart';
import '../../../location/data/data/repository_impl/location_repository_impl.dart';
import '../../../location/location_bloc/enable_loction_bloc.dart';

class EnableLocationScreen extends StatefulWidget {
  final String role;
  const EnableLocationScreen({super.key, required this.role});

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  final locatebloc = EnableLoctionBloc(LocationRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    ImageWidget(imageUrl: "assets/png/location.png", size: 200),
                    10.verticalSpace,
                    TextView(
                      text:
                      "For Technical reasons,Hire Cook App will need access to you location,for better and smarter experience",
                      align: TextAlign.center,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    10.verticalSpace,

                    TextView(
                      align: TextAlign.center,
                      text: "Enable location for better Access",
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
            ),

            BlocConsumer<EnableLoctionBloc, EnableLoctionState>(
              bloc: locatebloc,
              listener:_listentToEnableState,
              builder: (context, state) {
                return CustomButton(
                  child: TextView(
                    text: "Allow Access",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {
                    allowAccess();
                  },
                );
              },
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  void allowAccess() {
    locatebloc.add(EnableMyLocationEvent());
  }

  void _listentToEnableState(BuildContext context, EnableLoctionState state) {
    if(state is LocationLoadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is LocationErrorstate){
      Navigator.pop(context);
      CustomDialogs.showToast(state.error);
    }
    if(state is LocationSuccessState){
      Navigator.pop(context);

      CustomDialogs.showToast("Location Enabled");

      if(widget.role=="Client/User"){
        Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>BasePage()));

      }
      else{
        Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>Onboarding1()));

      }

    }
  }
}
