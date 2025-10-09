import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/cook_onboarding/presentations/screens/onboarding_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/filled_textfield.dart';
import '../../../../core/theme/pallets.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  String? selectedStatus;
  final List<String> status = [
    "Single",
    "Divorced",
    "Married",
    "Single Mom",
    "Preferred Not To Say",
  ];

  final shopLocationController = TextEditingController();
  final shopController = TextEditingController();
  final chargeController = TextEditingController();
  final experienceController = TextEditingController();
  final introController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.verticalSpace,
                TextView(text: "Set up your cook profile", fontSize: 15),
                10.verticalSpace,
                TextView(
                  text:
                      "Complete your cook/chef profile to be visible for potential clients",
                  fontSize: 11,
                ),
                20.verticalSpace,

                Row(
                  children: [
                    TextView(text: "Shop/Business Location", fontSize: 13),
                    TextView(text: "*", fontSize: 13, color: Colors.red),
                  ],
                ),
                5.verticalSpace,
                FilledTextField(
                  hint: "",
                  controller: shopLocationController,
                  outlineColor: Color(0xfffaab65),
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                Row(
                  children: [
                    TextView(text: "Business Address", fontSize: 13),
                    TextView(text: "*", fontSize: 13, color: Colors.red),
                  ],
                ),
                5.verticalSpace,
                FilledTextField(
                  hint: "",
                  controller: shopController,
                  outlineColor: Color(0xfffaab65),
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                Row(
                  children: [
                    TextView(text: "Charge Per Hour", fontSize: 13),
                    TextView(text: "*", fontSize: 13, color: Colors.red),
                  ],
                ),
                5.verticalSpace,
                FilledTextField(
                  hint: "",
                  controller: chargeController,
                  outlineColor: Color(0xfffaab65),
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                Row(
                  children: [
                    TextView(text: "Years Of Experience", fontSize: 13),
                    TextView(text: "*", fontSize: 13, color: Colors.red),
                  ],
                ),
                5.verticalSpace,
                FilledTextField(
                  hint: "",
                  controller: experienceController,
                  outlineColor: Color(0xfffaab65),
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,

                Row(
                  children: [
                    TextView(text: "Marriage Status", fontSize: 13),
                    TextView(text: "*", fontSize: 13, color: Colors.red),
                  ],
                ),
                5.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Pallets.grey95),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const TextView(
                        text: "marriage status",
                        fontSize: 12,
                        color: Pallets.grey35,
                      ),
                      value: selectedStatus,
                      onChanged: (String? value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                      items:
                          status
                              .map(
                                (String reason) => DropdownMenuItem<String>(
                                  value: reason,
                                  child: TextView(text: reason, fontSize: 16),
                                ),
                              )
                              .toList(),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 250.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Iconsax.arrow_down_1, color: Pallets.grey35),
                      ),
                    ),
                  ),
                ),

                20.verticalSpace,
                Row(
                  children: [
                    TextView(text: "Brief Introduction", fontSize: 13),
                    TextView(text: "*", fontSize: 13, color: Colors.red),
                  ],
                ),
                5.verticalSpace,

                FilledTextField(
                  hint: "My name is ....",
                  controller: introController,
                  outlineColor: Color(0xfffaab65),
                  maxLine: 4,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                CustomButton(
                  child: TextView(
                    text: "Continue",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {
                    validateUser();
                  },
                ),
                15.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateUser() {
    if (key.currentState!.validate()) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder:
              (ctx) => Onboarding2(
                payload: CookPayload(
                  selectedStatus!,
                  shopLocationController.text.trim(),
                  shopController.text.trim(),
                  chargeController.text.trim(),
                  experienceController.text.trim().toString(),
                  introController.text.trim(),
                ),
              ),
        ),
      );
    }
  }
}
