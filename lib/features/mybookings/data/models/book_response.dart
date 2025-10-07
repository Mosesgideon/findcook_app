import 'package:cloud_firestore/cloud_firestore.dart';

class AppBookingResponse {
  final String? cookId;
  final String? clientId;
  final String? cookName;
  final String? clientName;
  final String? cookEmail;
  final String? clientEmail;
  final String? cookAbout;
  final String? cookLocation;
  final String? clientLocation;
  final String? yearsOfExperience;
  final List<String> cookType;
  final String? cookChargePerHr;
  final String? cookmarriageStatus;
  final String? clientmarriageStatus;
  final List<String> cookLanguages;
  final String? cookUsername;
  final String? cookReligion;
  final String? cookPhone;
  final String? clientPhone;
  final String? cookProfileImage;
  final String? clientProfileImage;
  final String? cookCoverImage;
  final String? cookHouseAddress;
  final String? clientHouseAddress;
  final List<String> cookGallery;
  final List<String> clientSelectedServices;
  final List<String> clientSelectedSpecialMeals;
  final String? notes;
  final DateTime? bookedTime;
  final String status; // ✅ booking status

  AppBookingResponse({
    this.cookId,
    this.clientId,
    this.cookName,
    this.clientName,
    this.cookEmail,
    this.clientEmail,
    this.cookAbout,
    this.cookLocation,
    this.clientLocation,
    this.yearsOfExperience,
    this.cookType = const [],
    this.cookChargePerHr,
    this.cookmarriageStatus,
    this.clientmarriageStatus,
    this.cookLanguages = const [],
    this.cookUsername,
    this.cookReligion,
    this.cookPhone,
    this.clientPhone,
    this.cookProfileImage,
    this.clientProfileImage,
    this.cookCoverImage,
    this.cookHouseAddress,
    this.clientHouseAddress,
    this.cookGallery = const [],
    this.clientSelectedServices = const [],
    this.clientSelectedSpecialMeals = const [],
    this.notes,
    this.bookedTime,
    this.status = "pending", // default value
  });

  /// Factory constructor to create from JSON (Firestore or API)
  factory AppBookingResponse.fromJson(Map<String, dynamic> json) {
    return AppBookingResponse(
      cookId: json['cookId'] as String?,
      clientId: json['clientId'] as String?,
      cookName: json['cookName'] as String?,
      clientName: json['clientName'] as String?,
      cookEmail: json['cookEmail'] as String?,
      clientEmail: json['clientEmail'] as String?,
      cookAbout: json['cookAbout'] as String?,
      cookLocation: json['cookLocation'] as String?,
      clientLocation: json['clientLocation'] as String?,
      yearsOfExperience: json['yearsOfExperience'] as String?,
      cookType: List<String>.from(json['cookType'] ?? []),
      cookChargePerHr: json['cookChargePerHr'] as String?,
      cookmarriageStatus: json['cookmarriageStatus'] as String?,
      clientmarriageStatus: json['clientmarriageStatus'] as String?,
      cookLanguages: List<String>.from(json['cookLanguages'] ?? []),
      cookUsername: json['cookUsername'] as String?,
      cookReligion: json['cookReligion'] as String?,
      cookPhone: json['cookPhone'] as String?,
      clientPhone: json['clientPhone'] as String?,
      cookProfileImage: json['cookProfileImage'] as String?,
      clientProfileImage: json['clientProfileImage'] as String?,
      cookCoverImage: json['cookCoverImage'] as String?,
      cookHouseAddress: json['cookHouseAddress'] as String?,
      clientHouseAddress: json['clientHouseAddress'] as String?,
      cookGallery: List<String>.from(json['cookGallery'] ?? []),
      clientSelectedServices: List<String>.from(json['clientSelectedServices'] ?? []),
      clientSelectedSpecialMeals: List<String>.from(json['clientSelectedSpecialMeals'] ?? []),
      notes: json['notes'] as String?,
      bookedTime: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(json['createdAt'].toString()))
          : null,
      status: json['status'] as String? ?? "pending",
    );
  }

  /// Convert back to JSON (for Firestore/API)
  Map<String, dynamic> toJson() {
    return {
      "cookId": cookId,
      "clientId": clientId,
      "cookName": cookName,
      "clientName": clientName,
      "cookEmail": cookEmail,
      "clientEmail": clientEmail,
      "cookAbout": cookAbout,
      "cookLocation": cookLocation,
      "clientLocation": clientLocation,
      "yearsOfExperience": yearsOfExperience,
      "cookType": cookType,
      "cookChargePerHr": cookChargePerHr,
      "cookmarriageStatus": cookmarriageStatus,
      "clientmarriageStatus": clientmarriageStatus,
      "cookLanguages": cookLanguages,
      "cookUsername": cookUsername,
      "cookReligion": cookReligion,
      "cookPhone": cookPhone,
      "clientPhone": clientPhone,
      "cookProfileImage": cookProfileImage,
      "clientProfileImage": clientProfileImage,
      "cookCoverImage": cookCoverImage,
      "cookHouseAddress": cookHouseAddress,
      "clientHouseAddress": clientHouseAddress,
      "cookGallery": cookGallery,
      "clientSelectedServices": clientSelectedServices,
      "clientSelectedSpecialMeals": clientSelectedSpecialMeals,
      "notes": notes,
      "createdAt": bookedTime != null ? Timestamp.fromDate(bookedTime!) : null,
      "status": status,
    };
  }
}


