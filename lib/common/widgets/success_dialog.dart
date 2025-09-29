import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/core/theme/pallets.dart';
// import 'package:find_cook/gen/assets.gen.dart';


class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {super.key,
      this.tittle,
      this.message,
      this.onTap,
      this.btnText,
      this.child});

  final String? tittle;
  final String? btnText;
  final String? message;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Pallets.successGreen,
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
            text: tittle ?? "Successful !!",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            color: Pallets.white,
          ),
          17.verticalSpace,
         child?? TextView(
            align: TextAlign.center,
            text: message ?? "Congratulations !!",
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
              foregroundColor: Pallets.successGreen,
              onPressed: onTap ?? () {},
              child: TextView(
                text: btnText ?? 'Back to Home',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          40.verticalSpace
        ],
      ),
    );
  }
}
