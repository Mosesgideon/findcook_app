import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:see_more/see_more_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/outlined_form_field.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../../core/theme/pallets.dart';
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

  bool islike = false;
  bool isLoading = false;

  @override
  void initState() {
    feeds.add(GetfeedsEvent());
    islike = islike;
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
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


                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute space
                              children: [

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StreamBuilder(
                                        stream: userLikedPost(feedItems[ctx].postId.toString()),
                                        builder: (context, snapshot) {
                                          int likes = 0;
                                          if (snapshot.hasData && snapshot.data != null) {
                                            likes = snapshot.data!.docs.length;
                                            log(snapshot.data!.docs.length.toString());
                                          }
                                          return InkWell(
                                            onTap: () {
                                              if (likes == 0) {
                                                likeUserPost(feedItems[ctx].postId.toString());
                                                log('liked');
                                              } else {
                                                unLikeUserPost(feedItems[ctx].postId.toString());
                                                log('unliked');
                                              }
                                              log('message');
                                            },
                                            child: likes == 0
                                                ? Icon(
                                              Iconsax.like_1,
                                              size: 25,
                                              color: Theme.of(context).colorScheme.onBackground,
                                            )
                                                : const Icon(
                                              Iconsax.like_1,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                          );
                                        },
                                      ),
                                      4.horizontalSpace,
                                      StreamBuilder(
                                        stream: postLikes(feedItems[ctx].postId.toString()),
                                        builder: (context, snapshot) {
                                          // FIXED: Add null safety
                                          if (!snapshot.hasData || snapshot.data == null) {
                                            return Text('0');
                                          }
                                          return Text(
                                            snapshot.data!.docs.length.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),


                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      CustomDialogs.showBottomSheet(
                                        context,
                                        VideoCommentBottomSheet(
                                          commenterName: user?.fullname ?? '',
                                          commenterID: user?.userID ?? '',
                                          postID: feed.postId ?? '',
                                          posterName: feed.posterName ?? '',
                                          posterID: feed.posterId ?? '',
                                        ),

                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Iconsax.message),
                                        4.horizontalSpace,
                                        StreamBuilder<QuerySnapshot>(
                                          stream: store
                                              .where("postID", isEqualTo: feedItems[ctx].postId)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            // FIXED: Add null safety
                                            if (!snapshot.hasData || snapshot.data == null) {
                                              return TextView(text: '0', fontSize: 10);
                                            }
                                            final comments = snapshot.data!.docs;
                                            return TextView(
                                              text: comments.length.toString(),
                                              fontSize: 10,
                                              textOverflow: TextOverflow.ellipsis,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      shareitem(
                                        "Shared post from Cook Services\n\n${feed.video.toString() ?? ''}",
                                        feed.writeUp ?? '',
                                      );
                                    },
                                    child:  Icon(
                                      Icons.share,
                                      color: Colors.black87.withOpacity(0.6),
                                    ),
                                  ),
                                ),

                                150.horizontalSpace,
                              ],
                            ),
                          ),
                          10.verticalSpace,
                          SeeMoreWidget(

                            feed.writeUp ?? '',
                            textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            animationDuration: Duration(milliseconds: 200),
                            seeMoreText: "See More",
                            seeMoreStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            seeLessText: "See Less",
                            seeLessStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            trimLength: 150,
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
  Stream<QuerySnapshot<Map<String, dynamic>>> userLikedPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('videolikes')
        .where('postId', isEqualTo: postId)
        .where('liker', isEqualTo: currentUser?.uid)
        .snapshots();

    return document;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> postLikes(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('videolikes')
        .where('postId', isEqualTo: postId)
        .snapshots();

    return document;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> heartIconLikes(String postID) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('feedImagelikes')
        .where('postID', isEqualTo: postID)
        .where('like', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userheartIconLike(String postID) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = FirebaseFirestore.instance
        .collection('feedImagelikes')
        .where('postID', isEqualTo: postID)
        .where('like', isEqualTo: currentUser!.uid)
        .snapshots();

    return document;
  }

  void likeUserPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('videolikes').doc().set({
      'postId': postId,
      'liker': currentUser!.uid,
    });
  }

  void unLikeUserPost(String postId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('videolikes')
        .where('postId', isEqualTo: postId)
        .where('liker', isEqualTo: currentUser!.uid)
        .get();

    if (document.docs.isNotEmpty) {
      for (var element in document.docs) {
        element.reference.delete();
      }
    }
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
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
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
        height: 400,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage =
            visibilityInfo.visibleFraction * 100;

        if (visiblePercentage < 50) {
          // 👈 Pause when user scrolls past
          if (_videoController.value.isPlaying) {
            _videoController.pause();
          }
        }
      },
      child: Container(
        height: 600,
        child: Chewie(controller: _chewieController!),
      ),
    );
  }

  /// 👇 Called when user navigates away (back, tab switch, etc.)
  @override
  void deactivate() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

class VideoCommentBottomSheet extends StatefulWidget {

  final String commenterName;
  final String posterName;
  final String commenterID;
  final String postID;
  final String posterID;
  const VideoCommentBottomSheet({super.key, required this.commenterName, required this.commenterID, required this.postID, required this.posterName, required this.posterID});

  @override
  State<VideoCommentBottomSheet> createState() => _VideoCommentBottomSheetState();
}
class _VideoCommentBottomSheetState extends State<VideoCommentBottomSheet> {
  final controller=TextEditingController();
  final store=FirebaseFirestore.instance.collection("feedVideComment");
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),
          ),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              TextView(text: "Comment on ${widget.posterName} Post",fontWeight: FontWeight.w500,),
              20.verticalSpace,

              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder<QuerySnapshot>(
                    stream: store
                        .where("postID", isEqualTo: widget.postID)

                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if(snapshot.hasError){
                        print(snapshot.error);
                        return Center(child:
                        Container(
                          width: 1.sw,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.orange)),
                          child: TextView(text: "Try Again",onTap: (){
                            store
                                .where("postID", isEqualTo: widget.postID)
                                .orderBy("commentDate", descending: true)
                                .snapshots();
                          },),)

                          ,);
                      }
                      if(snapshot.hasData){
                        if(snapshot.data!.docs.isEmpty){

                          return Column(
                            children: [
                              Icon(Iconsax.book_1),
                              4.verticalSpace,
                              TextView(text: "No comments"),
                            ],
                          );
                        }
                        final comments = snapshot.data!.docs;
                        return Column(
                          children: List.generate(comments.length, (ctx){
                            final comment = comments[ctx];
                            final data = comment.data() as Map<String, dynamic>;

                            final name = data["commenterName"] ?? "Anonymous";
                            final text = data["comment"] ?? "";
                            final date = (data["commentDate"] as Timestamp?)?.toDate();

                            final formattedDate = date != null
                                ? "${date.day}-${date.month}-${date.year}"
                                : "";
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.08)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(text:  data["commenterName"] , fontSize: 12,),
                                    Row(

                                      children: [
                                        TextView(
                                          text: data["comment"] ,
                                          fontSize: 14,),
                                        10.horizontalSpace,
                                        TextView(text: formattedDate, fontSize: 10,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }

                      return SizedBox();
                    }
                ),
              ),
              20.verticalSpace,
            ],
          ),


          OutlinedFormField(hint: "comment....",controller: controller,suffix: InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                sendComment(controller.text.trim());

              },
              child: Icon(Iconsax.send_1,color: Pallets.orange,)),)
        ],
      ),

    );
  }

  void sendComment(String comment,) {
    final store=FirebaseFirestore.instance.collection("feedVideComment");
    if(controller.text.isNotEmpty){
      store.add({
        "comment":comment,
        "commenterName":widget.commenterName,
        "commenterID":widget.commenterID,
        "postID":widget.postID,
        "commentDate":Timestamp.now(),
      });

      controller.clear();


    }
  }
}


