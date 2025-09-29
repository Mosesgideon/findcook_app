import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/theme/pallets.dart';


class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key,
      required this.onChecked,
      required this.value,
      this.checkedWidget,
      this.unCheckedWidget,
      this.checkedColor,
      this.unCheckedColor,
      this.trailing,
      this.leading,
      this.checkedIconSize,
      this.unCheckedIconSize});

  final Function(bool val) onChecked;
  final bool value;
  final Widget? checkedWidget;
  final Widget? unCheckedWidget;
  final Color? checkedColor;
  final Color? unCheckedColor;
  final Widget? trailing;
  final Widget? leading;
  final double? checkedIconSize;
  final double? unCheckedIconSize;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChecked(!widget.value);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.leading ?? const SizedBox.shrink(),
            8.horizontalSpace,
            widget.value
                ? widget.checkedWidget ??
                    Icon(
                      Iconsax.tick_square4,
                      color: widget.checkedColor ?? Pallets.darkblue,
                      size: widget.checkedIconSize ?? 16,
                    )
                : widget.unCheckedWidget ??
                    Icon(
                      Iconsax.refresh_square_24,
                      color: widget.unCheckedColor ?? Pallets.darkblue,
                      size: widget.unCheckedIconSize ?? 16,
                    ),
            8.horizontalSpace,
            widget.trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
