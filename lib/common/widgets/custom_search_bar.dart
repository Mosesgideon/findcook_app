// import 'package:fops/common/widgets/filled_textfield.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:find_cook/common/widgets/action_button.dart';


import '../../core/theme/pallets.dart';
import 'filled_textfield.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar(
      {Key? key,
      required this.tittle,
      this.onChanged,
      this.onFieldSubmitted,
      this.onSaved})
      : super(key: key);
  final String tittle;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onSaved;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return FilledTextField(
      hint: widget.tittle,
      hasElevation: false,
      outline: true,
      hasBorder: true,
      onChanged: widget.onChanged,
      outlineColor: Pallets.grey95,
      radius: 100,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      suffix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 2),
        child: CustomActionButton(
          gradient: const LinearGradient(colors: [
            Pallets.secondary,
            Pallets.secondary,
            Pallets.secondary2,
          ]),
          size: 30,
          child: Icon(
            Iconsax.search_normal_14,
            color: Pallets.white,
          ),
          onTap: () {},
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      fillColor: Pallets.buttonGrey.withOpacity(0.5),
    );
  }
}
