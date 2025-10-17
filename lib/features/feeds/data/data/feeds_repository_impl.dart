import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/feeds/data/models/postmodels.dart';

import 'package:find_cook/features/feeds/data/models/postresponse.dart';

import '../../domain/feeds_repository.dart';

class FeedsRepositoryImpl extends FeedsRepository {
  final CollectionReference feeds =
  FirebaseFirestore.instance.collection('Feeds');
  @override
  Future<PostResponseModel> postfeeds(PostModel payload) async {
    var response =await feeds.add(payload.toJson());

    return PostResponseModel.fromJson({
      "status": "success",
      "message": "Feed created successfully",
      "postID": response.id,
      ...payload.toJson(),
    });
  }
}