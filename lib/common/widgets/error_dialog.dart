import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/core/theme/pallets.dart';


import 'custom_button.dart';


class ErrorDialog extends StatelessWidget {
  const ErrorDialog(
      {super.key, this.tittle, this.message, this.onTap, this.btnText});

  final String? tittle;
  final String? btnText;
  final String? message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Pallets.errorRed,
        // borderRadius: BorderRadius.circular(16)
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
           ImageWidget(
            imageUrl: '',
            height: 90,
          ),
          10.verticalSpace,
          TextView(
            text: tittle ?? "Ooops sorry!!",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            color: Pallets.white,
          ),
          17.verticalSpace,
          TextView(
            align: TextAlign.center,
            text: message ?? "Something went wrong Please try again",
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Pallets.white,
          ),
          40.verticalSpace,
          CustomButton(
              bgColor: Pallets.white,
              elevation: 0,
              padding: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(8),
              foregroundColor: Pallets.errorRed,
              onPressed: onTap ?? () {},
              child: TextView(
                text: btnText ?? 'Try again',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          40.verticalSpace
        ],
      ),
    );
  }
}
