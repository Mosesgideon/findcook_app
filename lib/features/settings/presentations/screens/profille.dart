import 'dart:math';

import 'package:dio/dio.dart';
import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/filled_textfield.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/core/theme/pallets.dart';
import 'package:find_cook/features/authentication/data/models/auth_response.dart';
import 'package:find_cook/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../../../authentication/presentation/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  String? uploadedImageUrl;
  String? uploadedFileUrl;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  final update = AuthBloc(AuthRepositoryImpl());
  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
      fullnamecontroller.text = user?.fullname ?? '';
      numbercontroller.text = user?.phone ?? '';
      usernamecontroller.text = user?.username ?? '';
      hhouseAddresscontroller.text = user?.houseAddress ?? '';
    });
  }

  final picker = ImagePicker();
  XFile? profileImage;
  bool isUploadingImage = false;

  final fullnamecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final hhouseAddresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (isUploadingImage)
                      const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if ((uploadedImageUrl != null &&
                            uploadedImageUrl!.isNotEmpty) ||
                        (user?.profileImage != null &&
                            user!.profileImage.isNotEmpty))
                      ImageWidget(
                        imageUrl: uploadedImageUrl ?? user?.profileImage ?? '',
                        size: 100,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      )
                    else
                      CircleAvatar(
                        radius: 50,

                        child: Icon(Iconsax.user, size: 40),
                      ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: InkWell(
                        onTap: pickImage,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Pallets.grey75,
                          child: Icon(Iconsax.camera),
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,

                TextView(text: user?.email ?? ''),
                TextView(text: user?.role ?? '', fontSize: 12),
                TextView(text: user?.username ?? '', fontSize: 12),
              ],
            ),

            40.verticalSpace,
            FilledTextField(hint: "", controller: fullnamecontroller),
            15.verticalSpace,

            FilledTextField(hint: "", controller: usernamecontroller),
            15.verticalSpace,
            FilledTextField(hint: "", controller: numbercontroller),
            15.verticalSpace,
            FilledTextField(hint: "", controller: hhouseAddresscontroller),
            80.verticalSpace,
            BlocConsumer<AuthBloc, AuthState>(
              bloc: update,
              listener: _listenoUpdateSate,
              builder: (context, state) {
                return CustomButton(
                  child: TextView(
                    text: "Update Profile",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {
                    updateProfile();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      profileImage = image;
      isUploadingImage = true;
    });
    String? imageUrl = await _uploadImage(image);
    if (imageUrl != null) {
      uploadedImageUrl = imageUrl;
      uploadedFileUrl = imageUrl;
      print("Image URL: $uploadedFileUrl");
      setState(() => isUploadingImage = false);
    }
  }

  Future<String?> _uploadImage(XFile image) async {
    final cloudinaryUrl = "https://api.cloudinary.com/v1_1/dvt9bcjul/upload";
    final uploadPreset = "cookApp";

    setState(() => isUploadingImage = true);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path, filename: "upload.jpg"),
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
        print("Failed to upload image.");
        return null;
        setState(() => isUploadingImage = false);
      }
    } catch (e) {
      print("Error uploading image: $e");
      setState(() => isUploadingImage = false);
      return null;
    }
  }

  void updateProfile() {
    update.add(
      UpdateEvent(
        AuthPayload(
          fullname: fullnamecontroller.text.trim(),
          email: user?.email ?? '',
          username: user?.username ?? '',
          phone: user?.phone ?? '',
          houseAddress: hhouseAddresscontroller.text.trim(),
          password: user?.password ?? '',
          role: user?.role ?? '',
          profileImage: uploadedImageUrl?.isNotEmpty == true
              ? uploadedImageUrl!
              : user?.profileImage ?? '',
        ),
      ),
    );
  }

  void _listenoUpdateSate(BuildContext context, AuthState state) {
    if (state is AuthloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is AuthfailuireState) {
      CustomDialogs.showToast(state.error,isError: true);
      Navigator.pop(context);
    }
    if (state is AuthSuccessState) {
      CustomDialogs.showToast("Update successful");
      Navigator.pop(context);
      Navigator.pop(context);

    }
  }
}
