import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/core/theme/pallets.dart';


class DropdownFieldButton extends StatefulWidget {
  const DropdownFieldButton(
      {Key? key,
      required this.hint,
      required this.onTap,
      this.val,
      this.preffix,
      this.decoration,
      this.label,
      this.isRequired = true})
      : super(key: key);
  final String hint;
  final String? val;
  final VoidCallback onTap;
  final Widget? preffix;
  final String? label;
  final bool? isRequired;
  final Decoration? decoration;

  @override
  State<DropdownFieldButton> createState() => _DropdownFieldButtonState();
}

class _DropdownFieldButtonState extends State<DropdownFieldButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(builder: (context) {
          if (widget.label != null) {
            return Row(
              children: [
                TextView(
                  text: widget.label!,
                  style: GoogleFonts.sora(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                if (widget.isRequired!)
                  const TextView(
                    text: " *",
                    color: Pallets.error,
                  ),
              ],
            );
          }
          return const SizedBox();
        }),
        8.verticalSpace,
        InkWell(
          onTap: () => widget.onTap(),
          child: Container(
            decoration: widget.decoration ??
                BoxDecoration(
                    border: Border.all(color: Pallets.grey.withOpacity(0.3)),
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                IconTheme(
                    data: const IconThemeData(color: Colors.grey),
                    child: widget.preffix ?? 0.horizontalSpace),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    (widget.val != null && widget.val!.isNotEmpty)
                        ? widget.val!
                        : widget.hint,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
