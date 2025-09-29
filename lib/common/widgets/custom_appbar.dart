import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:find_cook/common/widgets/text_view.dart';

import '../../core/theme/pallets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.actions,
      this.leading,
      this.tittle,
      this.tittleText,
      this.onBackPressed,
      this.elevation,
      this.bgColor,
      this.fgColor = Pallets.primary,
      this.height,
      this.canGoBack = true});

  final List<Widget>? actions;
  final Widget? leading;
  final Widget? tittle;
  final String? tittleText;
  final double? elevation;
  final VoidCallback? onBackPressed;
  final Color? bgColor;
  final Color? fgColor;
  final double? height;
  final bool? canGoBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ??  Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: fgColor,
      surfaceTintColor: bgColor ??  Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation ?? 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Theme.of(context).colorScheme.onBackground),
      leading: canGoBack!
          ? IconButton(
              onPressed: () {
                onBackPressed != null ? onBackPressed!() : Navigator.pop(context);
              },
              icon: leading ??
                  Icon(
                    Iconsax.arrow_left_2,
                    color:
                        fgColor ?? Theme.of(context).colorScheme.onBackground,
                  ),
            )
          : null,
      title: tittle ??
          TextView(
            text: tittleText ?? '',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            style: GoogleFonts.sora(
                // fontSize: 16,

                color: fgColor),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
