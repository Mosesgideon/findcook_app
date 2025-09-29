import 'package:find_cook/features/authentication/presentation/screens/enable_location.dart';
import 'package:find_cook/features/authentication/presentation/screens/signin.dart';
import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../common/widgets/filled_textfield.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final key=GlobalKey<FormState>();
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final numberController=TextEditingController();
  final addressController=TextEditingController();
  final stateController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                40.verticalSpace,
                Center(child: ImageWidget(imageUrl: "assets/png/logo.png",size: 100,)),
                10.verticalSpace,
                TextView(text: "Welcome !",fontSize: 18,),
                TextView(text: "Because every good story begins with good food.",fontSize: 12,),
                20.verticalSpace,
                TextView(text: "Full Name"),
                5.verticalSpace,
                FilledTextField(hint: "John Jeo",
                  controller: nameController,
                  validator:
                MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,),
                15.verticalSpace,
                TextView(text: "Email Address"),
                5.verticalSpace,
                FilledTextField(hint: "JohnJeo@gmail.com",
                  controller: emailController,
                  validator:
                MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,),
                15.verticalSpace,
                TextView(text: "Phone Number"),
                5.verticalSpace,
                FilledTextField(hint: "+1(0)55433232",
                  controller: numberController,
                  validator:
                MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,),
                15.verticalSpace,
                TextView(text: "House Address/Number"),
                5.verticalSpace,
                FilledTextField(hint: "N0 14 lagos street",
                  controller: addressController,
                  validator:
                MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,),
                15.verticalSpace,
                TextView(text: "Password"),
                5.verticalSpace,
                FilledTextField(hint: "*******",
                  controller: passwordController,
                  outlineColor: Color(0xfffaab65),
                  validator:
                  MultiValidator([
                    RequiredValidator(errorText: 'This field is required'),
                  ]).call,),
                40.verticalSpace,
                CustomButton(child: TextView(text: "Register",color: Colors.white,fontWeight: FontWeight.w700,), onPressed: (){
                  registerUser();
                }),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(text: "Already have an account? "),
                    TextView(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>SigninScreen()));
                      },
                      text: "Login",color: Color(0xfffaab65)
                      ,fontWeight: FontWeight.w700
                      ,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() {
    if(key.currentState!.validate()){
      Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>EnableLocationScreen()));

    }
  }
}
