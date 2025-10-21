import '../../../authentication/data/models/AuthSuccessResponse.dart';

class PostModel {
  final String image;
  final String video;
  final String posterName;
  final String posterID;
  final String postType;
  final UserLocation location;
  final String writeUp;

  PostModel({
    required this.image,
    required this.video,
    required this.posterName,
    required this.posterID,
    required this.postType,
    required this.location,
    required this.writeUp,
  });

  // Convert object to JSON (payload)
  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "video": video,
      "posterName": posterName,
      "posterID": posterID,
      // "postID": postID,
      "postType": postType,
      'location': location.toJson(),
      // "timePosted": timePosted,
      "writeUp": writeUp,
    };
  }

  // Create object from JSON (for parsing API responses)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      image: json["image"] ?? "",
      video: json["video"] ?? "",
      posterName: json["posterName"] ?? "",
      posterID: json["posterID"] ?? "",
      postType: json["postType"] ?? "",
      // postID: json["postID"] ?? "",
      location: json["location"] ?? "",
      // timePosted: json["timePosted"] ?? "",
      writeUp: json["writeUp"] ?? "",
    );
  }
}
