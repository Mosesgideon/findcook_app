import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../core/theme/app_styles.dart';
import '../../core/theme/pallets.dart';

class FilledTextField extends StatefulWidget {
  final String hint;
  final Widget? suffix;
  final Widget? preffix;
  final FocusNode? focusNode;
  final int? maxLine;
  final int? minLine;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? obscured;
  final bool? outline;
  final bool? autofocus;
  final VoidCallback? voidCallback;
  final bool? hasElevation;
  final bool? hasBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? textColor;
  final Color? outlineColor;
  final String? Function(String?)? validator;

  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onSaved;
  final GlobalKey<FormFieldState<dynamic>>? formKey;

  final double radius;

  const FilledTextField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.controller,
      this.onChanged,
      this.enabled,
      this.contentPadding,
      this.textInputAction,
      this.obscured = false,
      this.fillColor,
      this.focusNode,
      this.outline = false,
      this.autofocus = false,
      this.hasElevation = true,
      this.formKey,
      this.minLine,
      this.onFieldSubmitted,
      this.onSaved,
      this.hasBorder = true,
      this.radius = 10,
      this.textColor,
      this.outlineColor, this.voidCallback})
      : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      key: widget.formKey,
      controller: widget.controller,
      maxLines: widget.maxLine ?? 1,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).colorScheme.onBackground,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      obscureText: widget.obscured!,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus!,
      minLines: widget.minLine,
      onTap: (){
        widget.voidCallback;
      },
      textInputAction: widget.textInputAction,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
          letterSpacing: 1,
          color:
          widget.textColor ?? Theme.of(context).colorScheme.onBackground,
          fontSize: 16,
          fontWeight: FontWeight.w500),
      decoration: AppStyles.filledTextFieldDecoration.copyWith(
          fillColor:
          widget.fillColor ?? Theme.of(context).colorScheme.surface,
          enabledBorder: widget.hasBorder!
              ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide:
              BorderSide(color: Pallets.grey.withOpacity(0.1)))
              : OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hint,

          suffixIcon: widget.suffix,
          focusedBorder: widget.outline!
              ? OutlineInputBorder(
              gapPadding: 2,
              borderSide: BorderSide(
                color: widget.outlineColor ?? Color(0xfffaab65),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.radius))
              : OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.outlineColor ?? Color(0xfffaab65),
              width: 1,
            ),
          ),
          border: widget.hasBorder!
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.outlineColor ??
                  Theme.of(context).colorScheme.surface,
              width: 1,
            ),
          )
              : OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.outlineColor ??
                  Theme.of(context).colorScheme.surface,
              width: 1,
            ),
          ),
          prefixIcon: widget.preffix,
          prefixIconColor: Pallets.grey,
          suffixIconColor: Theme.of(context).colorScheme.primary,
          enabled: widget.enabled,
          contentPadding: widget.contentPadding ?? const EdgeInsets.all(10),
          filled: true,

          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13,letterSpacing: 2,)),
    );
  }
}
