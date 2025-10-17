class PostModel {
  final String image;
  final String video;
  final String posterName;
  final String posterID;
  final String postID;
  final String posterLocation;
  final String timePosted;
  final String writeUp;

  PostModel({
    required this.image,
    required this.video,
    required this.posterName,
    required this.posterID,
    required this.postID,
    required this.posterLocation,
    required this.timePosted,
    required this.writeUp,
  });

  // Convert object to JSON (payload)
  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "video": video,
      "posterName": posterName,
      "posterID": posterID,
      "postID": postID,
      "posterLocation": posterLocation,
      "timePosted": timePosted,
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
      postID: json["postID"] ?? "",
      posterLocation: json["posterLocation"] ?? "",
      timePosted: json["timePosted"] ?? "",
      writeUp: json["writeUp"] ?? "",
    );
  }
}
