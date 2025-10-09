import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppCookModelResponse {
  final User? user;
  final String? cookID;
  final String cookName;//
  final String cookEmail;//
  final String cookAbout;//
  final String cookLocation;//
  final String yearsOfExperience;//
  final List<String> cookType;
  final String cookChargePerHr;//
  final String marriageStatus;//
  final List<String> cookLanguages;
  final String cookUsername;//
  final String cookReligion;//
  final String cookPhone;//
  final String cookProfileImage;
  final String cookCoverImage;
  final String cookHouseAddress;//
  final String role;//
  final List<String> cookGallery;
  final List<String> cookServices;
  final List<String> cookSpecialMeals;
  final List<CookRating> ratings;

  const AppCookModelResponse({
    this.user,
    this.cookID,
    required this.cookName,
    required this.cookEmail,
    required this.cookAbout,
    required this.cookLocation,
    required this.cookLanguages,
    required this.cookUsername,
    required this.cookType,
    required this.cookChargePerHr,
    required this.yearsOfExperience,
    required this.cookReligion,
    required this.marriageStatus,
    required this.cookPhone,
    required this.cookProfileImage,
    required this.cookCoverImage,
    required this.cookHouseAddress,
    required this.cookGallery,
    required this.cookServices,
    required this.role,
    required this.cookSpecialMeals,
    required this.ratings,
  });

  factory AppCookModelResponse.fromJson(Map<String, dynamic> json, {User? user}) {
    return AppCookModelResponse(
      user: user,
      cookID: json['cookID']?.toString(),
      cookName: json['cookName']?.toString() ?? '',
      cookEmail: json['cookEmail']?.toString() ?? '',
      cookAbout: json['cookAbout']?.toString() ?? '',
      cookLocation: json['cookLocation']?.toString() ?? '',
      cookType: List<String>.from(json['cookType'] ?? []),   // ✅ FIX
      cookChargePerHr: json['cookChargePerHr']?.toString() ?? '',
      marriageStatus: json['marriageStatus']?.toString() ?? '',
      yearsOfExperience: json['yearsOfExperience']?.toString() ?? '',
      cookLanguages: List<String>.from(json['cookLanguages'] ?? []),
      cookUsername: json['cookUsername']?.toString() ?? '',
      cookReligion: json['cookReligion']?.toString() ?? '',
      cookPhone: json['cookPhone']?.toString() ?? '',
      cookProfileImage: json['cookProfileImage']?.toString() ?? '',
      cookCoverImage: json['cookCoverImage']?.toString() ?? '',
      cookHouseAddress: json['cookHouseAddress']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      cookGallery: List<String>.from(json['cookGallery'] ?? []),
      cookServices: List<String>.from(json['cookServices'] ?? []),
      cookSpecialMeals: List<String>.from(json['cookSpecialMeals'] ?? []),
      ratings: (json['ratings'] is List)
          ? (json['ratings'] as List<dynamic>)
          .map((e) => CookRating.fromJson(e))
          .toList()
          : [],   // ✅ Fix: fallback to []
    );
  }
}


/// Rating model
class CookRating {
  final String userID;
  final String userName;
  final double ratingValue;
  final String comment;
  final DateTime createdAt;

  CookRating({
    required this.userID,
    required this.userName,
    required this.ratingValue,
    required this.comment,
    required this.createdAt,
  });

  factory CookRating.fromJson(Map<String, dynamic> json) {
    return CookRating(
      userID: json['userID'] ?? '',
      userName: json['userName'] ?? '',
      ratingValue: (json['ratingValue'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'userName': userName,
      'ratingValue': ratingValue,
      'comment': comment,
      'createdAt': createdAt,
    };
  }
}
