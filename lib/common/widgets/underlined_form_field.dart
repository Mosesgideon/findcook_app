import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:find_cook/common/widgets/text_view.dart';
// import 'package:find_cook/core/constants/package_exports.dart';
import 'package:find_cook/core/theme/pallets.dart';

class UnderlinedFormField extends StatefulWidget {
  const UnderlinedFormField(
      {Key? key,
        required this.hint,
        this.suffix,
        this.validator,
        this.preffix,
        this.maxLine,
        this.inputType,
        this.obscure,
        this.controller,
        this.onChange,
        this.onFieldSubmitted,
        this.enabled,
        this.inputFormatters,
        this.placeHolder,
        this.minlines,
        this.isRequired = true,
        this.trailingPlaceHolder})
      : super(key: key);
  final String hint;
  final String? placeHolder;
  final Widget? trailingPlaceHolder;
  final bool? isRequired;
  final bool? obscure;
  final Widget? suffix;
  final Widget? preffix;
  final int? maxLine;
  final int? minlines;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String d)? onChange;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;


  @override
  State<UnderlinedFormField> createState() => _UnderlinedFormFieldState();
}

class _UnderlinedFormFieldState extends State<UnderlinedFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          if (widget.placeHolder != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: widget.placeHolder!.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Pallets.primary),
                ),
                if (widget.trailingPlaceHolder != null)
                  widget.trailingPlaceHolder!

                // if (widget.isRequired!)
                //   const TextView(
                //     text: " *",
                //     color: Pallets.error,
                //   ),
              ],
            ),
          8.verticalSpace,
          TextFormField(
            minLines: widget.minlines,
            controller: widget.controller,
            validator: widget.validator,
            maxLines: widget.maxLine ?? 1,
            onChanged: widget.onChange,
            keyboardType: widget.inputType,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscure == null ? false : widget.obscure!,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16.sp),

            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: Pallets.grey75),
              suffixIcon: widget.suffix,
              fillColor: Theme.of(context).cardColor,
              prefixIcon: widget.preffix,
              iconColor: Colors.grey,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
              enabled: widget.enabled ?? true,
              prefixIconColor: Colors.grey,
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Pallets.grey60),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Pallets.grey60),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Pallets.grey60),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Pallets.grey60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
