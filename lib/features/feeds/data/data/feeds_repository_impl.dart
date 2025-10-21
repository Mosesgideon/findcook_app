import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/feeds/data/models/postmodels.dart';

import 'package:find_cook/features/feeds/data/models/postresponse.dart';

import '../../../authentication/data/models/AuthSuccessResponse.dart';
import '../../domain/feeds_repository.dart';

class FeedsRepositoryImpl extends FeedsRepository {
  final CollectionReference feeds = FirebaseFirestore.instance.collection(
    'Feeds',
  );
  @override
  Future<PostResponseModel> postfeeds(PostModel payload) async {
    final docRef = feeds.doc();

    final postsModel = {
      "image": payload.image,
      "video": payload.video,
      "posterName": payload.posterName,
      "posterID": payload.posterID,
      "postType": payload.postType,
      "postID": docRef.id,
      "location": payload.location is UserLocation
          ? (payload.location).toJson()
          : payload.location,
      "timePosted": FieldValue.serverTimestamp(),
      "writeUp": payload.writeUp,
    };

    await docRef.set(postsModel);


    return PostResponseModel.fromJson({
      "status": "success",
      "message": "Feed created successfully",
      "postID": docRef.id,
      ...payload.toJson(),
    });
  }

  @override
  Future<PostResponseModel> getfeeds() async {
    final firestore = FirebaseFirestore.instance;
    var response = await firestore.collection("Feeds").get();

    List<Data> posts = response.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Data(
        image: data["image"] ?? '',
        video: data["video"] ?? '',
        posterName: data["posterName"] ?? '',
        posterId: data["posterID"] ?? '',
        postId: data["postID"] ?? doc.id,
        posterLocation: data["location"] != null
            ? UserLocation.fromJson(Map<String, dynamic>.from(data["location"]))
            : null,
        timePosted: data["timePosted"] != null
            ? (data["timePosted"] as Timestamp).toDate()
            : DateTime.now(),
        writeUp: data["writeUp"] ?? '',
        postType: data["postType"],
        poster_profile: data["poster_profile"],
      );
    }).toList();

    return PostResponseModel(
      status: "success",
      message: "Feeds fetched successfully",
      data: posts,
    );



  }
}
