import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/features/authentication/data/models/auth_response.dart';
import 'package:find_cook/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:find_cook/features/authentication/presentation/auth_bloc/auth_bloc.dart';
import 'package:find_cook/features/authentication/presentation/screens/enable_location.dart';
import 'package:find_cook/features/authentication/presentation/screens/signin.dart';
import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../common/widgets/filled_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final authbloc = AuthBloc(AuthRepositoryImpl());

  final List identity=["Client/User","Cook/Chef"];

  String? selectedIdentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                40.verticalSpace,
                Center(
                  child: ImageWidget(
                    imageUrl: "assets/png/logo.png",
                    size: 100,
                  ),
                ),
                10.verticalSpace,
                TextView(text: "Hello Welcome!", fontSize: 18),
                TextView(
                  text: "Because every good story begins with good food.",
                  fontSize: 12,
                ),
                20.verticalSpace,
                TextView(text: "Full Name"),
                5.verticalSpace,
                FilledTextField(
                  hint: "John Jeo",
                  controller: nameController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Email Address"),
                5.verticalSpace,
                FilledTextField(
                  hint: "JohnJeo@gmail.com",
                  controller: emailController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Preferred username"),
                5.verticalSpace,
                FilledTextField(
                  hint: "Ken",
                  controller: usernameController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Phone Number"),
                5.verticalSpace,
                FilledTextField(
                  hint: "+1(0)55433232",
                  controller: numberController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "House Address/Number"),
                5.verticalSpace,
                FilledTextField(
                  hint: "N0 14 lagos street",
                  controller: addressController,
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                15.verticalSpace,
                TextView(text: "Password"),
                5.verticalSpace,
                FilledTextField(
                  hint: "*******",
                  controller: passwordController,
                  outlineColor: Color(0xfffaab65),
                  validator:
                      MultiValidator([
                        RequiredValidator(errorText: 'This field is required'),
                      ]).call,
                ),
                40.verticalSpace,
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authbloc,
                  listener: _listentoAuthState,
                  builder: (context, state) {
                    return CustomButton(
                      child: TextView(
                        text: "Register",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      onPressed: () {
                        registerUser();
                      },
                    );
                  },
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(text: "Already have an account? "),
                    TextView(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (ctx) => SigninScreen()),
                        );
                      },
                      text: "Login",
                      color: Color(0xfffaab65),
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() {

    if (key.currentState!.validate()) {

      CustomDialogs.showBottomSheet(context, StatefulBuilder(

        builder: (BuildContext context, void Function(void Function()) setState) {
          return  Container(
            width: 1.sw,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),
                ),
                color: Colors.white
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextView(text: "How do we identify you?",),
                // TextView(text: "Please select who you are",),
                20.verticalSpace,

                ...List.generate(identity.length, (index)=>  Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: (){
                      setState(() {
                        selectedIdentity = identity[index];
                      });
                    },
                    child: Row(
                      children: [
                        Icon(selectedIdentity == identity[index]
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                          color: selectedIdentity == identity[index]
                              ? Color(0xfffaab65)
                              : Colors.grey,
                          size: 15,),
                        5.horizontalSpace,
                        TextView(text: identity[index]),
                      ],
                    ),
                  ),
                )),
                20.verticalSpace,
                CustomButton(child: TextView(text: "Register"), onPressed: (){

                  if(selectedIdentity==null||selectedIdentity!.isEmpty){

                    CustomDialogs.showToast("please select whom you are");
                  }
                  authbloc.add(
                    RegisterEvent(
                      AuthPayload(
                          fullname: nameController.text.trim(),
                          email: emailController.text.trim(),
                          username: usernameController.text.trim(),
                          phone: numberController.text.trim(),
                          houseAddress: addressController.text.trim(),
                          password: passwordController.text.trim(),
                          role:selectedIdentity!
                      ),
                    ),
                  );
                })


              ],
            ),
          );
        },

      ));

    }
  }

  void _listentoAuthState(BuildContext context, AuthState state) {
    if (state is AuthloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthfailuireState) {
      CustomDialogs.showToast(state.error,isError: true);
      Navigator.pop(context);
    }
    if (state is AuthSuccessState) {
      CustomDialogs.showToast("Registration successful");
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (ctx) => EnableLocationScreen(role: selectedIdentity.toString(),)),
      );
    }
  }
}
