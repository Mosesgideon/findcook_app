
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:find_cook/common/widgets/text_view.dart';

import '../../core/theme/pallets.dart';
import 'image_widget.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog(
      {Key? key,
      this.image,
      this.imageWidget,
      this.footer,
      this.tittle,
      this.subtittle})
      : super(key: key);
  final String? image;
  final Widget? imageWidget;
  final Widget? footer;
  final String? tittle;
  final String? subtittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null)
            ImageWidget(
              imageUrl: image!,
              size: 150.h,
            ),
          imageWidget ?? 0.verticalSpace,
          16.verticalSpace,
          TextView(
            align: TextAlign.center,
            text: tittle ?? "",
            style: TextStyle(

                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Pallets.darkblue),
          ),
          16.verticalSpace,
          if (subtittle != null)
            TextView(
              text: subtittle ?? "",
              style:  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Pallets.grey.withOpacity(0.5)),
              align: TextAlign.center,
            ),
          footer ?? 0.verticalSpace,

          const SpinKitFadingCircle(
            size: 50,
            color: Pallets.orange,
          ),
        ],
      ),
    );
  }
}
