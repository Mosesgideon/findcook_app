import 'dart:io';
import 'package:dio/dio.dart';
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
  final addcook = CookBloc(AllCooksRepositoryImpl());
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  // Add these variables to track upload state
  bool _isUploading = false;
  String? _profileImageUrl;
  String? _coverImageUrl;
  List<String> _galleryImageUrls = [];

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
                    items: religion
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
                children: services
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
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'This field is required',
                        ),
                      ]).call,
                    ),
                  ),
                  8.horizontalSpace,
                  TextView(text: "Add", onTap: _addServices),
                ],
              ),
              15.verticalSpace,
              TextView(text: "Special Meals You Cook", fontSize: 13),
              5.verticalSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: cookSpecialMeals
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
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'This field is required',
                        ),
                      ]).call,
                    ),
                  ),
                  8.horizontalSpace,
                  TextView(text: "Add", onTap: _addcookSpecialMeals),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  TextView(text: "Profile Image"),
                  TextView(text: "*", color: Colors.red),
                ],
              ),
              10.verticalSpace,
              profilefile != null
                  ? Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallets.grey90),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        2.horizontalSpace,
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              profilefile = null;
                              _profileImageUrl = null;
                            });
                          },
                          child: Icon(Icons.cancel_rounded, color: Colors.grey),
                        )
                      ],
                    ),
                    10.verticalSpace,
                    ClipOval(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(profilefile!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (_profileImageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "✓ Uploaded to Cloudinary",
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              )
                  : InkWell(
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
                  TextView(text: "*", color: Colors.red),
                ],
              ),
              10.verticalSpace,
              file != null
                  ? Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallets.grey90),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        2.horizontalSpace,
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              file = null;
                              _coverImageUrl = null;
                            });
                          },
                          child: Icon(Icons.cancel_rounded, color: Colors.grey),
                        )
                      ],
                    ),
                    10.verticalSpace,
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(File(file!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (_coverImageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "✓ Uploaded to Cloudinary",
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              )
                  : InkWell(
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
                  TextView(text: "*", color: Colors.red),
                ],
              ),
              10.verticalSpace,
              myfile != null && myfile!.isNotEmpty
                  ? Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myfile!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(myfile![index].path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (_galleryImageUrls.length > index)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.check, color: Colors.white, size: 12),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (_galleryImageUrls.isNotEmpty && _galleryImageUrls.length == myfile!.length)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "✓ All gallery images uploaded to Cloudinary",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                ],
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
                    child: _isUploading
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        10.horizontalSpace,
                        TextView(
                          text: "Uploading Images...",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    )
                        : TextView(
                      text: "Proceed",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: _isUploading ? null : () => registerCook(),
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
          _galleryImageUrls = []; // Reset gallery URLs when new images are selected
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
    var profileimage = await picker.pickImage(source: ImageSource.gallery);
    if (profileimage == null) return;
    setState(() {
      profilefile = profileimage;
      _profileImageUrl = null; // Reset URL when new image is selected
    });
  }

  Future<void> _pickCoverImage() async {
    var coverimage = await picker.pickImage(source: ImageSource.gallery);
    if (coverimage == null) return;
    setState(() {
      file = coverimage;
      _coverImageUrl = null; // Reset URL when new image is selected
    });
  }

  Future<String?> _uploadImage(String imagePath) async {
    final cloudinaryUrl = "https://api.cloudinary.com/v1_1/dvt9bcjul/upload";
    final uploadPreset = "cookApp";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        imagePath,
        filename: "image_${DateTime.now().millisecondsSinceEpoch}.jpg",
      ),
      "upload_preset": uploadPreset,
    });

    try {
      Dio dio = Dio();
      Response response = await dio.post(cloudinaryUrl, data: formData);

      if (response.statusCode == 200) {
        String uploadedImageUrl = response.data["secure_url"];
        print("Image Uploaded Successfully: $uploadedImageUrl");
        return uploadedImageUrl;
      } else {
        print("Failed to upload image. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _uploadAllImages() async {
    setState(() {
      _isUploading = true;
    });

    try {
      // Upload profile image
      if (profilefile != null && _profileImageUrl == null) {
        _profileImageUrl = await _uploadImage(profilefile!.path);
      }

      // Upload cover image
      if (file != null && _coverImageUrl == null) {
        _coverImageUrl = await _uploadImage(file!.path);
      }

      // Upload gallery images
      if (myfile != null && myfile!.isNotEmpty) {
        _galleryImageUrls = [];
        for (var galleryFile in myfile!) {
          final url = await _uploadImage(galleryFile.path);
          if (url != null) {
            _galleryImageUrls.add(url);
          }
        }
      }

      setState(() {
        _isUploading = false;
      });

      // Check if all required images are uploaded
      if (profilefile != null && _profileImageUrl == null) {
        CustomDialogs.showToast("Failed to upload profile image", isError: true);
        return;
      }

      if (file != null && _coverImageUrl == null) {
        CustomDialogs.showToast("Failed to upload cover image", isError: true);
        return;
      }

      if (myfile != null && myfile!.isNotEmpty && _galleryImageUrls.isEmpty) {
        CustomDialogs.showToast("Failed to upload gallery images", isError: true);
        return;
      }

    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      CustomDialogs.showToast("Error uploading images: $e", isError: true);
    }
  }

  void registerCook() async {
    // First validate required fields
    if (selectedreligion == null) {
      CustomDialogs.showToast("Please select your religion", isError: true);
      return;
    }

    if (profilefile == null) {
      CustomDialogs.showToast("Please upload profile image", isError: true);
      return;
    }

    if (file == null) {
      CustomDialogs.showToast("Please upload cover image", isError: true);
      return;
    }

    if (myfile == null || myfile!.isEmpty) {
      CustomDialogs.showToast("Please upload gallery images", isError: true);
      return;
    }

    // Upload all images first
    await _uploadAllImages();

    // Check if all images were uploaded successfully
    if (_profileImageUrl == null || _coverImageUrl == null || _galleryImageUrls.isEmpty) {
      CustomDialogs.showToast("Please wait for all images to upload", isError: true);
      return;
    }

    // Now register the cook with Cloudinary URLs
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
        cookProfileImage: _profileImageUrl!, // Use Cloudinary URL
        cookCoverImage: _coverImageUrl!, // Use Cloudinary URL
        cookHouseAddress: user!.houseAddress,
        cookGallery: _galleryImageUrls, // Use Cloudinary URLs
        cookServices: services,
        cookSpecialMeals: cookSpecialMeals,
      ),
    ));
  }

  void _listentToAddCookState(BuildContext context, CookState state) {
    if (state is CookLoadingSate) {
      CustomDialogs.showLoading(context);
    }
    if (state is CookFailuireSate) {
      Navigator.pop(context);
      CustomDialogs.showToast(state.error, isError: true);
    }
    if (state is AddCookSccessSate) {
      Navigator.pop(context);
      Navigator.push(context, CupertinoPageRoute(builder: (ctx) => BasePage()));
    }
  }
}
