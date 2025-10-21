import 'package:find_cook/features/authentication/data/models/AuthSuccessResponse.dart';

class PostResponseModel {
  PostResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<Data>? data; // ✅ Make it a list

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return PostResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.map((x) => x.toJson()).toList(),
  };
}


class Data {
  Data({
    required this.image,
    required this.video,
    required this.posterName,
    required this.posterId,
    required this.postId,
    required this.posterLocation,
    required this.timePosted,
    required this.writeUp,
    required this.postType,
    required this.poster_profile,
  });

  final String? image;
  final String? video;
  final String? posterName;
  final String? posterId;
  final String? postId;
  final UserLocation? posterLocation;
  final DateTime? timePosted;
  final String? writeUp;
  final String? postType;
  final String? poster_profile;

  Data copyWith({
    String? image,
    String? video,
    String? posterName,
    String? posterId,
    String? postId,
    UserLocation? posterLocation,
    DateTime? timePosted,
    String? writeUp,
    String? postType,
    String? poster_profile,
  }) {
    return Data(
      image: image ?? this.image,
      video: video ?? this.video,
      posterName: posterName ?? this.posterName,
      posterId: posterId ?? this.posterId,
      postId: postId ?? this.postId,
      posterLocation: posterLocation ?? this.posterLocation,
      timePosted: timePosted ?? this.timePosted,
      writeUp: writeUp ?? this.writeUp,
      postType: postType ?? this.postType,
      poster_profile: poster_profile ?? this.poster_profile,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      image: json["image"],
      video: json["video"],
      posterName: json["posterName"],
      posterId: json["posterID"],
      postId: json["postID"],
      posterLocation: json["location"],
      timePosted: DateTime.tryParse(json["timePosted"] ?? ""),
      writeUp: json["writeUp"],
      postType: json["postType"],
      poster_profile: json["poster_profile"],
    );
  }

  Map<String, dynamic> toJson() => {
    "image": image,
    "video": video,
    "posterName": posterName,
    "posterID": posterId,
    "postID": postId,
    "posterLocation": posterLocation,
    "timePosted": timePosted?.toIso8601String(),
    "writeUp": writeUp,
    "postType": postType,
    "poster_profile": poster_profile,
  };

  @override
  String toString(){
    return "$image, $video, $posterName, $posterId, $postId, $posterLocation, $timePosted, $writeUp,$postType ,$poster_profile";
  }
}
