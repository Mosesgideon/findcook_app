import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/common/widgets/error_widget.dart';
import 'package:find_cook/features/feeds/data/data/feeds_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:see_more/see_more_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../feeds_bloc/feeds_bloc.dart';
import 'app_feeds.dart';

class Feedimage extends StatefulWidget {
  const Feedimage({super.key});

  @override
  State<Feedimage> createState() => _FeedimageState();
}

class _FeedimageState extends State<Feedimage> {
  final feeds = FeedsBloc(FeedsRepositoryImpl());
  final shared = SharedPreferencesClass();
  AuthSuccessResponse? user;

  Future<void> _loadUser() async {
    final data = await SharedPreferencesClass.getUserData();
    setState(() {
      user = data;
    });
  }

  bool islike = false;
  bool isLoading = false;

  // bool herat = false;


  @override
  void initState() {
    // TODO: implement initState
    feeds.add(GetfeedsEvent());
    _loadUser();
    islike = islike;
    super.initState();
  }

  final store=FirebaseFirestore.instance.collection("feedImageComment");
  final likestore=FirebaseFirestore.instance.collection("feedImagelikes");
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
              if (state is FeedsErrorState) {
                return Center(child: AppPromptWidget());
              }
              if (state is GetFeedsSuccessState) {
                if (state.responseModel.data!.isEmpty) {
                  return Center(child: TextView(text: "No feeds available"));
                }
                final feedItems = state.responseModel.data!
                    .where((feed) => feed.postType == "image")
                    .toList();
                return Column(
                  children: List.generate(
                    feedItems.length,
                        (ctx) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ImageWidget(
                                imageUrl: feedItems[ctx].poster_profile ?? '',
                                width: 40,
                                height: 40,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0xfffaab65),
                                  width: 2,
                                ),
                              ),
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: feedItems[ctx].posterName ?? '',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                  TextView(
                                    text: feedItems[ctx]
                                        .posterLocation
                                        ?.placeName ??
                                        '',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 8,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          ImageWidget(
                            imageUrl: feedItems[ctx].image ?? '',
                            width: 1.sw,
                            height: 200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xfffaab65),
                              width: 1,
                            ),
                          ),
                          10.verticalSpace,
                          // FIXED: Wrap the action buttons Row with constraints
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute space evenly
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
                                        CommentBottomSheet(
                                          commenterName: user?.fullname ?? '',
                                          commenterID: user?.userID ?? '',
                                          postID: feedItems[ctx].postId ?? '',
                                          posterName: feedItems[ctx].posterName ?? '',
                                          posterID: feedItems[ctx].posterId ?? '',
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
                                        "Shared post from Cook Services\n\n${feedItems[ctx].writeUp ?? ''}",
                                        feedItems[ctx].image.toString() ?? '',
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.share,
                                          color: Colors.black87.withOpacity(0.6),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                150.horizontalSpace
                              ],
                            ),
                          ),
                          10.verticalSpace,
                          SeeMoreWidget(
                            feedItems[ctx].writeUp ?? '',
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
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userLikedPost(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .where('liker', isEqualTo: currentUser?.uid)
        .snapshots();

    return document;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> postLikes(String postId) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final document = FirebaseFirestore.instance
        .collection('likes')
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
    FirebaseFirestore.instance.collection('likes').doc().set({
      'postId': postId,
      'liker': currentUser!.uid,
    });
  }

  void unLikeUserPost(String postId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final document = await FirebaseFirestore.instance
        .collection('likes')
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
      print('Thank you for sharing my app!');
  }}
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
      print(state.responseModel.data?.first.image.toString());
    }
  }



}
