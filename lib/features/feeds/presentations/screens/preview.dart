import 'dart:io';

import 'package:dio/dio.dart';
import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/custom_dialogs.dart';
import 'package:find_cook/common/widgets/image_widget.dart';
import 'package:find_cook/common/widgets/outlined_form_field.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:find_cook/features/feeds/data/data/feeds_repository_impl.dart';
import 'package:find_cook/features/feeds/data/models/postmodels.dart';
import 'package:find_cook/features/feeds/presentations/feeds_bloc/feeds_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../../domain/feeds_repository.dart';
class PreviewScreen extends StatefulWidget {
  final String image ;
  final String video ;
  final String text ;
  const PreviewScreen({super.key, required this.image, required this.video, required this.text});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {




  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  final TextEditingController _writeUpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();

    if (widget.video != null && widget.video!.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.video!)
        ..initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
        });
    }
  }

  @override
  void dispose() {
    if (_isVideoInitialized) {
      _controller.dispose();
    }
    _writeUpController.dispose();
    super.dispose();
  }

  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;


  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }

  String? uploadedLink;
  bool _isUploading=false;
  final postbloc=FeedsBloc(FeedsRepositoryImpl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  widget.image != null
                      ? ImageWidget(
                    imageUrl: widget.image!,
                    height: 200,
                    width: 1.sw,
                    borderRadius: BorderRadius.circular(10),
                  )
                      : Container(
                    height: 400,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.video != null && widget.video!.isNotEmpty
                        ? _isVideoInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : const Center(child: CircularProgressIndicator())
                        : const Center(child: Text('No video found')),
                  ),
              20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: OutlinedFormField(hint: "add write up",maxLine: 4,
                    controller: _writeUpController,),
                  ),

                ],
              ),
            ),
            BlocConsumer<FeedsBloc, FeedsState>(
              bloc: postbloc,
  listener:_listenToPostState,
  builder: (context, state) {
    return CustomButton(child: TextView(text: "Post",fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,), onPressed: (){

              _postItem();
            });
  },
),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }


  Future<void> _postItem() async {
    if (_isUploading) return;

    setState(() {
      _isUploading = true;
      uploadedLink = null;
    });

    try {
      String? downloadUrl;

      if (widget.text == "image" && widget.image.isNotEmpty) {
        downloadUrl = await _uploadImage(File(widget.image));
      } else if (widget.text == "video" && widget.video.isNotEmpty) {
        downloadUrl = await _uploadVideo(File(widget.video));
      }

      setState(() {
        uploadedLink = downloadUrl;
      });

      if (downloadUrl != null) {
        print("✅ Upload successful: $downloadUrl");
        print("📝 Write up: ${_writeUpController.text}");
        postbloc.add(AddfeedsEvent(PostModel(image: widget.text=="image"?downloadUrl:'', video: widget.text=="video"?downloadUrl:'' , posterName:user?.fullname??'', posterID: user!.userID.toString(), postType: widget.text, location: user!.location, writeUp: _writeUpController.text.trim())));

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload media")),
        );
      }
    } catch (e) {
      print("Error in _postItem: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    final cloudinaryUrl = "https://api.cloudinary.com/v1_1/dvt9bcjul/upload";
    final uploadPreset = "cookApp";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: "image_${DateTime.now().millisecondsSinceEpoch}.jpg"
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

  Future<String?> _uploadVideo(File videoFile) async {
    final cloudinaryUrl = "https://api.cloudinary.com/v1_1/dvt9bcjul/upload";
    final uploadPreset = "cookApp";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          videoFile.path,
          filename: "video_${DateTime.now().millisecondsSinceEpoch}.mp4"
      ),
      "upload_preset": uploadPreset,
      "resource_type": "video",
    });

    try {
      Dio dio = Dio();
      // Increase timeout for videos
      dio.options.connectTimeout = Duration(seconds: 60);
      dio.options.receiveTimeout = Duration(seconds: 60);

      Response response = await dio.post(cloudinaryUrl, data: formData);

      if (response.statusCode == 200) {
        String uploadedVideoUrl = response.data["secure_url"];
        print("Video Uploaded Successfully: $uploadedVideoUrl");
        return uploadedVideoUrl;
      } else {
        print("Failed to upload video. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error uploading video: $e");
      return null;
    }
  }






  void _listenToPostState(BuildContext context, FeedsState state) {
    if(state is FeedsLoadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is FeedsErrorState){
      Navigator.pop(context);
      CustomDialogs.showToast(state.error,isError: true);
    }
    if(state is AddFeedsSuccessState){
      Navigator.pop(context);
      CustomDialogs.showToast("Post added Successful");

Navigator.pushReplacement(context, CupertinoPageRoute(builder: (ctx)=>BasePage()));
    }
  }
}
