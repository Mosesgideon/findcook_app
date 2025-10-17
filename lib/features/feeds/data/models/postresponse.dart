class PostResponseModel {
  PostResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  PostResponseModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) {
    return PostResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory PostResponseModel.fromJson(Map<String, dynamic> json){
    return PostResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$status, $message, $data, ";
  }
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
  });

  final String? image;
  final String? video;
  final String? posterName;
  final String? posterId;
  final String? postId;
  final String? posterLocation;
  final DateTime? timePosted;
  final String? writeUp;

  Data copyWith({
    String? image,
    String? video,
    String? posterName,
    String? posterId,
    String? postId,
    String? posterLocation,
    DateTime? timePosted,
    String? writeUp,
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
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      image: json["image"],
      video: json["video"],
      posterName: json["posterName"],
      posterId: json["posterID"],
      postId: json["postID"],
      posterLocation: json["posterLocation"],
      timePosted: DateTime.tryParse(json["timePosted"] ?? ""),
      writeUp: json["writeUp"],
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
  };

  @override
  String toString(){
    return "$image, $video, $posterName, $posterId, $postId, $posterLocation, $timePosted, $writeUp, ";
  }
}
