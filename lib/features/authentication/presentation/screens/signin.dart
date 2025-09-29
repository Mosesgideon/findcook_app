import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/outlined_form_field.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/authentication/presentation/screens/signup.dart';
import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../common/widgets/filled_textfield.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final key=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              40.verticalSpace,
              Center(child: ImageWidget(imageUrl: "assets/png/logo.png",size: 100,)),
              10.verticalSpace,
              TextView(text: "Welcome back!",fontSize: 18,),
              TextView(text: "Because every good story begins with good food.",fontSize: 12,),
              20.verticalSpace,
           /*   TextView(text: "Full Name"),
              5.verticalSpace,
              FilledTextField(hint: "John Jeo"),*/
              15.verticalSpace,
              TextView(text: "Email Address"),
              5.verticalSpace,
              FilledTextField(hint: "JohnJeo@gmail.com",controller: emailController,
                validator:
                MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,),
              15.verticalSpace,
              TextView(text: "Password"),
              5.verticalSpace,
              FilledTextField(hint: "*******",
                validator:
                MultiValidator([
                  RequiredValidator(errorText: 'This field is required'),
                ]).call,
              controller: passwordController,
              outlineColor: Color(0xfffaab65),),
              40.verticalSpace,
              CustomButton(child: TextView(text: "Login",color: Colors.white,fontWeight: FontWeight.w700,), onPressed: (){
                loginuser();
              }),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(text: "Don't have an account? "),
                  TextView(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>SignupScreen()));
                    },
                    text: "Register",color: Color(0xfffaab65)
                    ,fontWeight: FontWeight.w700
                    ,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginuser() {
    if(key.currentState!.validate()){
      Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>BasePage()));
    }
  }
}
