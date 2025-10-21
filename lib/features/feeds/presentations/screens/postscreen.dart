import 'dart:io';

import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/custom_button.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:find_cook/features/feeds/presentations/screens/preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../onboarding/screens/onbaord_screens.dart';
class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final imagePicker = ImagePicker();
  final videoPicker = ImagePicker();
  XFile? file;
  XFile? videoFile;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlassmorphicContainer(
                    width: 150,
                    height: 100,
                    borderRadius: 20,
                    blur: 20,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.5),
                        Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          openGallery();
                        },
                        child: Icon(Iconsax.add, size: 30, color: Color(0xfffaab65)),
                      ),
                    ),
                  ),
                  GlassmorphicContainer(
                    width: 150,
                    height: 100,
                    borderRadius: 20,
                    blur: 20,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.5),
                        Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          pickVideo();
                        },
                        child: Icon(Iconsax.add, size: 30, color: Color(0xfffaab65)),
                      ),
                    ),
                  ),
                ],
              ),

              file != null
                  ? Image.file(File(file!.path), height: 400, width: 1.sw, fit: BoxFit.fitWidth)
                  : SizedBox(),

              videoFile != null
                  ? Container(
                height: 400,
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _videoController != null && _videoController!.value.isInitialized
                    ? VideoPlayer(_videoController!)
                    : Center(child: CircularProgressIndicator()),
              )

                  : SizedBox(),

              60.verticalSpace,
              (file != null || videoFile != null)
                  ? CustomButton(
                child: TextView(
                  text: "Next",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () { // Determine the text based on what's selected
                  String mediaType = file != null ? "image" : "video";
   print(mediaType);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (ctx) => PreviewScreen(
                            image: file?.path ?? '',
                            video: videoFile?.path ?? '',
                            text: file != null ? "image" : "video",
                          )
                      )
                  );
                },
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Clean up video controller if switching to image
    if (_videoController != null) {
      _videoController!.dispose();
      _videoController = null;
    }

    setState(() {
      file = image;
      videoFile = null;
    });
  }

  Future<void> pickVideo() async {
    final XFile? pickedFile = await videoPicker.pickVideo(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // Clean up previous controller
      if (_videoController != null) {
        _videoController!.dispose();
      }

      // Initialize new video controller
      _videoController = VideoPlayerController.file(File(pickedFile.path))
        ..initialize().then((_) {
          setState(() {});
        });

      setState(() {
        videoFile = pickedFile;
        file = null;
      });
      print("✅ Video path: ${pickedFile.path}");
    } else {
      print("⚠️ No video selected");
    }
  }
}