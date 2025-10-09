class AppCookPayload {
  AppCookPayload({
    required this.cookId,
    required this.cookName,
    required this.cookEmail,
    required this.cookAbout,
    required this.cookLocation,
    required this.yearsOfExperience,
    required this.cookType,
    required this.cookChargePerHr,
    required this.marriageStatus,
    required this.cookLanguages,
    required this.cookUsername,
    required this.cookReligion,
    required this.cookPhone,
    required this.cookProfileImage,
    required this.cookCoverImage,
    required this.cookHouseAddress,
    required this.cookGallery,
    required this.cookServices,
    required this.cookSpecialMeals,
  });

  final String? cookId;
  final String? cookName;
  final String? cookEmail;
  final String? cookAbout;
  final String? cookLocation;
  final String? yearsOfExperience;
  final List<String> cookType;
  final String? cookChargePerHr;
  final String? marriageStatus;
  final List<String> cookLanguages;
  final String? cookUsername;
  final String? cookReligion;
  final String? cookPhone;
  final String? cookProfileImage;
  final String? cookCoverImage;
  final String? cookHouseAddress;
  final List<String> cookGallery;
  final List<String> cookServices;
  final List<String> cookSpecialMeals;

  AppCookPayload copyWith({
    String? cookId,
    String? cookName,
    String? cookEmail,
    String? cookAbout,
    String? cookLocation,
    String? yearsOfExperience,
    List<String>? cookType,
    String? cookChargePerHr,
    String? marriageStatus,
    List<String>? cookLanguages,
    String? cookUsername,
    String? cookReligion,
    String? cookPhone,
    String? cookProfileImage,
    String? cookCoverImage,
    String? cookHouseAddress,
    List<String>? cookGallery,
    List<String>? cookServices,
    List<String>? cookSpecialMeals,
  }) {
    return AppCookPayload(
      cookId: cookId ?? this.cookId,
      cookName: cookName ?? this.cookName,
      cookEmail: cookEmail ?? this.cookEmail,
      cookAbout: cookAbout ?? this.cookAbout,
      cookLocation: cookLocation ?? this.cookLocation,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      cookType: cookType ?? this.cookType,
      cookChargePerHr: cookChargePerHr ?? this.cookChargePerHr,
      marriageStatus: marriageStatus ?? this.marriageStatus,
      cookLanguages: cookLanguages ?? this.cookLanguages,
      cookUsername: cookUsername ?? this.cookUsername,
      cookReligion: cookReligion ?? this.cookReligion,
      cookPhone: cookPhone ?? this.cookPhone,
      cookProfileImage: cookProfileImage ?? this.cookProfileImage,
      cookCoverImage: cookCoverImage ?? this.cookCoverImage,
      cookHouseAddress: cookHouseAddress ?? this.cookHouseAddress,
      cookGallery: cookGallery ?? this.cookGallery,
      cookServices: cookServices ?? this.cookServices,
      cookSpecialMeals: cookSpecialMeals ?? this.cookSpecialMeals,
    );
  }

  factory AppCookPayload.fromJson(Map<String, dynamic> json){
    return AppCookPayload(
      cookId: json["cookID"],
      cookName: json["cookName"],
      cookEmail: json["cookEmail"],
      cookAbout: json["cookAbout"],
      cookLocation: json["cookLocation"],
      yearsOfExperience: json["yearsOfExperience"],
      cookType: json["cookType"] == null ? [] : List<String>.from(json["cookType"]!.map((x) => x)),
      cookChargePerHr: json["cookChargePerHr"],
      marriageStatus: json["marriageStatus"],
      cookLanguages: json["cookLanguages"] == null ? [] : List<String>.from(json["cookLanguages"]!.map((x) => x)),
      cookUsername: json["cookUsername"],
      cookReligion: json["cookReligion"],
      cookPhone: json["cookPhone"],
      cookProfileImage: json["cookProfileImage"],
      cookCoverImage: json["cookCoverImage"],
      cookHouseAddress: json["cookHouseAddress"],
      cookGallery: json["cookGallery"] == null ? [] : List<String>.from(json["cookGallery"]!.map((x) => x)),
      cookServices: json["cookServices"] == null ? [] : List<String>.from(json["cookServices"]!.map((x) => x)),
      cookSpecialMeals: json["cookSpecialMeals"] == null ? [] : List<String>.from(json["cookSpecialMeals"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "cookID": cookId,
    "cookName": cookName,
    "cookEmail": cookEmail,
    "cookAbout": cookAbout,
    "cookLocation": cookLocation,
    "yearsOfExperience": yearsOfExperience,
    "cookType": cookType.map((x) => x).toList(),
    "cookChargePerHr": cookChargePerHr,
    "marriageStatus": marriageStatus,
    "cookLanguages": cookLanguages.map((x) => x).toList(),
    "cookUsername": cookUsername,
    "cookReligion": cookReligion,
    "cookPhone": cookPhone,
    "cookProfileImage": cookProfileImage,
    "cookCoverImage": cookCoverImage,
    "cookHouseAddress": cookHouseAddress,
    "cookGallery": cookGallery.map((x) => x).toList(),
    "cookServices": cookServices.map((x) => x).toList(),
    "cookSpecialMeals": cookSpecialMeals.map((x) => x).toList(),
  };

  @override
  String toString(){
    return "$cookId, $cookName, $cookEmail, $cookAbout, $cookLocation, $yearsOfExperience, $cookType, $cookChargePerHr, $marriageStatus, $cookLanguages, $cookUsername, $cookReligion, $cookPhone, $cookProfileImage, $cookCoverImage, $cookHouseAddress, $cookGallery, $cookServices, $cookSpecialMeals, ";
  }
}
