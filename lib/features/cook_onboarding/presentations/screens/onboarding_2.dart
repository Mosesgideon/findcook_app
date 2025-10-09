import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/features/cook_onboarding/data/models/cookpayload.dart';
import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:find_cook/features/home_screen/data/data/repository_impl.dart';
import 'package:find_cook/features/home_screen/presentations/bloc/cook_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/filled_textfield.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../../core/theme/pallets.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import 'onboarding_3.dart';



class CookPayload{
  String status;
  String shoplocation;
  String shpaddress;
  String charge;
  String experience;
  String introduction;

  CookPayload(this.status, this.shoplocation, this.shpaddress, this.charge,
      this.experience, this.introduction);

}
class Onboarding2 extends StatefulWidget {
  final CookPayload payload;

  const Onboarding2({super.key, required this.payload});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  final picker = ImagePicker();
  List<XFile>? myfile;
  XFile? file;
  XFile? profilefile;


  final List<String> religion = [
    "Christian",
    "Muslim",
    "Atheist",
    "Preferred Not To Say",
  ];
  final List<String> services = [];
  final List<String> cookSpecialMeals = [];
  final List<String> cookLanguages = [];
  final List<String> cookType = [];

  String? selectedreligion;

  final ServicesController = TextEditingController();
  final specialController = TextEditingController();
  final addcook=CookBloc(AllCooksRepositoryImpl());
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              50.verticalSpace,
              TextView(text: "Complete up your profile", fontSize: 15),

              15.verticalSpace,
              TextView(text: "Religion", fontSize: 13),
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
                      text: "select religion",
                      fontSize: 14,
                      color: Pallets.grey35,
                    ),
                    value: selectedreligion,
                    onChanged: (String? value) {
                      setState(() {
                        selectedreligion = value;
                      });
                    },
                    items:
                        religion
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
              15.verticalSpace,
              TextView(text: "Services You Offer", fontSize: 13),
              5.verticalSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    services
                        .map(
                          (color) => Chip(
                            label: Text(color.trim()),
                            backgroundColor: Colors.grey[200],
                            deleteIcon: Icon(Icons.close, size: 16),
                            onDeleted: () => _removeServices(color),
                          ),
                        )
                        .toList(),
              ),
              5.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: FilledTextField(
                      hint: "Event Service",
                      controller: ServicesController,
                      outlineColor: Color(0xfffaab65),
                      validator:
                          MultiValidator([
                            RequiredValidator(
                              errorText: 'This field is required',
                            ),
                          ]).call,
                    ),
                  ),
                  8.horizontalSpace,
                  TextView(text: "Add", onTap: _addServices),
                  // ElevatedButton(
                  //   onPressed: _addServices,
                  //   child: Text("Add"),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.symmetric(vertical: 16),
                  //   ),
                  // ),
                ],
              ),
              15.verticalSpace,
              TextView(text: "Special Meals You Cook", fontSize: 13),
              5.verticalSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    cookSpecialMeals
                        .map(
                          (color) => Chip(
                            label: Text(color.trim()),
                            backgroundColor: Colors.grey[200],
                            deleteIcon: Icon(Icons.close, size: 16),
                            onDeleted: () => _removecookSpecialMeals(color),
                          ),
                        )
                        .toList(),
              ),
              5.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: FilledTextField(
                      hint: "jollof rice....",
                      controller: specialController,
                      outlineColor: Color(0xfffaab65),
                      validator:
                          MultiValidator([
                            RequiredValidator(
                              errorText: 'This field is required',
                            ),
                          ]).call,
                    ),
                  ),
                  8.horizontalSpace,
                  TextView(text: "Add", onTap: _addcookSpecialMeals),
                  // ElevatedButton(
                  //   onPressed: _addServices,
                  //   child: Text("Add"),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.symmetric(vertical: 16),
                  //   ),
                  // ),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  TextView(text: "Profile Image"),
                  TextView(text: "*",color: Colors.red,),

                ],
              ),
              10.verticalSpace,
             profilefile !=null?
             Container(
               padding: EdgeInsets.only(top: 10),
               decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(color: Pallets.grey90)
               ),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       2.horizontalSpace,
                       InkWell(
                           splashColor: Colors.transparent,
                           onTap: (){
                             setState(() {
                               profilefile=null;
                             });
                           },

                           child: Icon(Icons.cancel_rounded,color: Colors.grey,))
                     ],
                   ),
                   10.verticalSpace,
                   ClipOval(
                     child: Container(
                       height: 120,
                       width: 120,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           image: DecorationImage(image: AssetImage(profilefile!.path,),fit: BoxFit.cover)
                     
                       ),
                     ),
                   ),
                 ],
               ),
             ):
             InkWell(
                onTap: () {
                  _pickProfileImage();
                },
                child: SizedBox(
                  width: 1.sw,
                  height: 80,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(10),
                      color: Pallets.grey60,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, color: Pallets.grey60),

                          10.horizontalSpace,
                          TextView(
                            text: "Click to upload profile image",
                            color: Pallets.grey60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              15.verticalSpace,
              Row(
                children: [
                  TextView(text: "Cover Image"),
                  TextView(text: "*",color: Colors.red,),

                ],
              ),
              10.verticalSpace,
             file !=null?
             Container(
               padding: EdgeInsets.only(top: 10),
               decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(color: Pallets.grey90)
               ),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       2.horizontalSpace,
                       InkWell(
                           splashColor: Colors.transparent,
                           onTap: (){
                             setState(() {
                               file=null;
                             });
                           },

                           child: Icon(Icons.cancel_rounded,color: Colors.grey,))
                     ],
                   ),
                   10.verticalSpace,
                   Container(
                     height: 120,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         image: DecorationImage(image: AssetImage(file!.path,),fit: BoxFit.cover)

                     ),
                   ),
                 ],
               ),
             ):
             InkWell(
                onTap: () {
                  _pickCoverImage();
                },
                child: SizedBox(
                  width: 1.sw,
                  height: 80,
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(10),
                      color: Pallets.grey60,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, color: Pallets.grey60),

                          10.horizontalSpace,
                          TextView(
                            text: "Click to upload cover image",
                            color: Pallets.grey60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              15.verticalSpace,
              Row(
                children: [
                  TextView(text: "Add Gallery"),
                  TextView(text: "*",color: Colors.red,),
                ],
              ),
              10.verticalSpace,
              myfile != null && myfile!.isNotEmpty
                  ? SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myfile!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(myfile![index].path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  : InkWell(
                    onTap: () {
                      _pickMultipleImages();
                    },
                    child: SizedBox(
                      width: 1.sw,
                      height: 80,
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(10),
                          color: Pallets.grey60,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file, color: Pallets.grey60),

                              10.horizontalSpace,
                              TextView(
                                text: "Click to upload image",
                                color: Pallets.grey60,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

              15.verticalSpace,
              BlocConsumer<CookBloc, CookState>(
                bloc: addcook,
  listener: _listentToAddCookState,
  builder: (context, state) {
    return CustomButton(
                child: TextView(
                  text: "Proceed",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () {
                 registerCook();
                },
              );
  },
),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _removeServices(String size) {
    setState(() {
      services.remove(size);
    });
  }

  void _removecookSpecialMeals(String size) {
    setState(() {
      cookSpecialMeals.remove(size);
    });
  }

  void _addServices() {
    final newSize = ServicesController.text.trim();
    if (newSize.isEmpty) return;

    if (!services.contains(newSize)) {
      setState(() {
        services.add(newSize);
        ServicesController.clear();
      });
    } else {
      CustomDialogs.showToast("This service already exists");
    }
  }

  void _addcookSpecialMeals() {
    final newSize = specialController.text.trim();
    if (newSize.isEmpty) return;

    if (!cookSpecialMeals.contains(newSize)) {
      setState(() {
        cookSpecialMeals.add(newSize);
        specialController.clear();
      });
    } else {
      CustomDialogs.showToast("This meal already exists");
    }
  }

  Future<void> _pickMultipleImages() async {
    try {
      var pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
        limit: 6,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          myfile = pickedFiles;
        });
      } else {
        CustomDialogs.showToast("No images selected");
      }
    } on MissingPluginException catch (e) {
      print("ImagePicker plugin not found: $e");
      CustomDialogs.showToast("Image picker not available on this device");
    } catch (e) {
      print("Error picking images: $e");
      CustomDialogs.showToast("Failed to pick images: ${e.toString()}");
    }
  }

  Future<void> _pickProfileImage() async {
    var profileimage=await picker.pickImage(source: ImageSource.gallery);
    if(profileimage==null)return;
    setState(() {
      profilefile=profileimage;
    });


  }
  Future<void> _pickCoverImage() async {
    var coverimage=await picker.pickImage(source: ImageSource.gallery);
    if(coverimage==null)return;
    setState(() {
      file=coverimage;
    });
  }

  void registerCook() {
    addcook.add(AddCookEvent(
      AppCookPayload(
        cookId: user!.userID.toString(),
        cookName: user!.fullname ?? '',
        cookEmail: user!.email,
        cookAbout: widget.payload.introduction,
        cookLocation: user!.location.placeName,
        yearsOfExperience: widget.payload.experience,
        cookType: cookType,
        cookChargePerHr: widget.payload.charge,
        marriageStatus: widget.payload.status,
        cookLanguages: cookLanguages,
        cookUsername: user!.username,
        cookReligion: selectedreligion!,
        cookPhone: user!.phone,
        cookProfileImage: profilefile!.path,
        cookCoverImage: file!.path,
        cookHouseAddress: user!.houseAddress,
        cookGallery: myfile?.map((img) => img.path).toList() ?? [],
        cookServices: services,
        cookSpecialMeals: cookSpecialMeals,
      ),
    ));
  }


  void _listentToAddCookState(BuildContext context, CookState state) {
    if(state is CookLoadingSate){
      CustomDialogs.showLoading(context);
    }
    if(state is CookFailuireSate){
      Navigator.pop(context);
      CustomDialogs.showToast(state.error,isError: true);
    }
    if(state is AddCookSccessSate){
      Navigator.pop(context);
      Navigator.push(context, CupertinoPageRoute(builder: (ctx)=>BasePage()));
    }
  }
}
