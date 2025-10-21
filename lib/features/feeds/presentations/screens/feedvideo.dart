import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../../data/data/feeds_repository_impl.dart';
import '../feeds_bloc/feeds_bloc.dart';
import 'app_feeds.dart';
import 'package:chewie/chewie.dart';

class Feedvideo extends StatefulWidget {
  const Feedvideo({super.key});

  @override
  State<Feedvideo> createState() => _FeedvideoState();
}

class _FeedvideoState extends State<Feedvideo> {
  final feeds = FeedsBloc(FeedsRepositoryImpl());
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  final store = FirebaseFirestore.instance.collection("feedVideComment");
  final likestore = FirebaseFirestore.instance.collection("feedVideolikes");

  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }

  @override
  void initState() {
    feeds.add(GetfeedsEvent());
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: BlocConsumer<FeedsBloc, FeedsState>(
            bloc: feeds,
            listener: _listenToGetFeedsState,
            builder: (context, state) {
              if (state is GetFeedsSuccessState) {


                final feedItems = state.responseModel.data!
                    .where((feed) => feed.postType == "video")
                    .toList();
                if (feedItems.isEmpty) {
                  return const Center(child: Text("No feeds available"));
                }

                return Column(
                  children: List.generate(feedItems.length, (ctx) {
                    final feed = feedItems[ctx];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ImageWidget(
                                imageUrl: feed.poster_profile ?? '',
                                width: 40,
                                height: 40,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xfffaab65),
                                  width: 2,
                                ),
                              ),
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: feed.posterName ?? '',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                  TextView(
                                    text: feed.posterLocation?.placeName ?? '',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 8,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          10.verticalSpace,

                          _FeedVideoPlayer(videoUrl: feed.video ?? ''),
                          10.verticalSpace,

                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite_border),
                                  4.horizontalSpace,
                                  TextView(text: "10", fontSize: 10),
                                ],
                              ),
                              30.horizontalSpace,
                              InkWell(
                                onTap: () {
                                  CustomDialogs.showBottomSheet(
                                    context,
                                    CommentBottomSheet(
                                      commenterName: user?.fullname ?? '',
                                      commenterID: user?.userID ?? '',
                                      postID: feedItems[ctx].postId ?? '', posterName: feedItems[ctx].posterName ?? '', posterID: feedItems[ctx].posterId ?? '',
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(Iconsax.message),
                                    4.horizontalSpace,
                                    StreamBuilder<QuerySnapshot>(
                                        stream:  store
                                            .where("postID", isEqualTo: feedItems[ctx].postId)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          final comments = snapshot.data!.docs;

                                          return TextView(text: comments.length.toString(), fontSize: 10);
                                        }
                                    ),
                                  ],
                                ),
                              ),
                              30.horizontalSpace,
                              InkWell(
                                onTap: (){
                                  shareitem(
                                    "Shared post from Cook Services\n\n${feedItems[ctx].writeUp ?? ''}",
                                    feedItems[ctx].image ?? '',
                                  );

                                },
                                child: Icon(
                                  Icons.share,
                                  color: Colors.black87.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          TextView(
                            text: feed.writeUp ?? '',
                            fontSize: 10,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future<void> shareitem(String code, String s) async {
    final result = await Share.share(code);
    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing!');
    }
  }

  void _listenToGetFeedsState(BuildContext context, FeedsState state) {
    if (state is FeedsLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is FeedsErrorState) {
      Navigator.pop(context);
      CustomDialogs.showToast(state.error, isError: true);
    }
    if (state is GetFeedsSuccessState) {
      Navigator.pop(context);
      print(state.responseModel.data?.first.video.toString());
    }
  }
}


class _FeedVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const _FeedVideoPlayer({required this.videoUrl});

  @override
  State<_FeedVideoPlayer> createState() => _FeedVideoPlayerState();
}

class _FeedVideoPlayerState extends State<_FeedVideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await _videoController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: false,
      aspectRatio: _videoController.value.aspectRatio,
    );
    setState(() => isInitialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return Container(
        width: 1.sw,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xfffaab65), width: 1),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xfffaab65)),
        ),
      );
    }

    return Container(
      width: 1.sw,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xfffaab65), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Chewie(controller: _chewieController!),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}


