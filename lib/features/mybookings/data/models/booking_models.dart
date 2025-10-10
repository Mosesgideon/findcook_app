class AppBookingModelPayload {
  AppBookingModelPayload({
    required this.docID,
    required this.cookId,
    required this.clientId,
    required this.cookName,
    required this.clientName,
    required this.cookEmail,
    required this.clientEmail,
    required this.cookAbout,
    required this.cookLocation,
    required this.clientLocation,
    required this.yearsOfExperience,
    required this.cookType,
    required this.cookChargePerHr,
    required this.cookmarriageStatus,
    required this.clientmarriageStatus,
    required this.cookLanguages,
    required this.cookUsername,
    required this.cookReligion,
    required this.cookPhone,
    required this.clientPhone,
    required this.cookProfileImage,
    required this.clientProfileImage,
    required this.cookCoverImage,
    required this.cookHouseAddress,
    required this.clientHouseAddress,
    required this.cookGallery,
    required this.clientSelectedServices,
    required this.clientSelectedSpecialMeals,
    required this.notes,
    required this.status,
    required this.eventstatus,
  });

  final String? docID;
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
  final String notes;
  final String status;
  final String eventstatus;

  AppBookingModelPayload copyWith({
    String? docID,
    String? cookId,
    String? clientId,
    String? cookName,
    String? clientName,
    String? cookEmail,
    String? clientEmail,
    String? cookAbout,
    String? cookLocation,
    String? clientLocation,
    String? yearsOfExperience,
    List<String>? cookType,
    String? cookChargePerHr,
    String? cookmarriageStatus,
    String? clientmarriageStatus,
    List<String>? cookLanguages,
    String? cookUsername,
    String? cookReligion,
    String? cookPhone,
    String? clientPhone,
    String? cookProfileImage,
    String? clientProfileImage,
    String? cookCoverImage,
    String? cookHouseAddress,
    String? clientHouseAddress,
    List<String>? cookGallery,
    List<String>? clientSelectedServices,
    List<String>? clientSelectedSpecialMeals,
    String? notes,
    String? status,
    String? eventstatus,
  }) {
    return AppBookingModelPayload(
      docID: docID ?? this.docID,
      cookId: cookId ?? this.cookId,
      clientId: clientId ?? this.clientId,
      cookName: cookName ?? this.cookName,
      clientName: clientName ?? this.clientName,
      cookEmail: cookEmail ?? this.cookEmail,
      clientEmail: clientEmail ?? this.clientEmail,
      cookAbout: cookAbout ?? this.cookAbout,
      cookLocation: cookLocation ?? this.cookLocation,
      clientLocation: clientLocation ?? this.clientLocation,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      cookType: cookType ?? this.cookType,
      cookChargePerHr: cookChargePerHr ?? this.cookChargePerHr,
      cookmarriageStatus: cookmarriageStatus ?? this.cookmarriageStatus,
      clientmarriageStatus: clientmarriageStatus ?? this.clientmarriageStatus,
      cookLanguages: cookLanguages ?? this.cookLanguages,
      cookUsername: cookUsername ?? this.cookUsername,
      cookReligion: cookReligion ?? this.cookReligion,
      cookPhone: cookPhone ?? this.cookPhone,
      clientPhone: clientPhone ?? this.clientPhone,
      cookProfileImage: cookProfileImage ?? this.cookProfileImage,
      clientProfileImage: clientProfileImage ?? this.clientProfileImage,
      cookCoverImage: cookCoverImage ?? this.cookCoverImage,
      cookHouseAddress: cookHouseAddress ?? this.cookHouseAddress,
      clientHouseAddress: clientHouseAddress ?? this.clientHouseAddress,
      cookGallery: cookGallery ?? this.cookGallery,
      clientSelectedServices: clientSelectedServices ?? this.clientSelectedServices,
      clientSelectedSpecialMeals: clientSelectedSpecialMeals ?? this.clientSelectedSpecialMeals,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      eventstatus: eventstatus ?? this.eventstatus,
    );
  }

  factory AppBookingModelPayload.fromJson(Map<String, dynamic> json){
    return AppBookingModelPayload(
      docID: json["docID"],
      cookId: json["cookID"],
      clientId: json["clientID"],
      cookName: json["cookName"],
      clientName: json["clientName"],
      cookEmail: json["cookEmail"],
      clientEmail: json["clientEmail"],
      cookAbout: json["cookAbout"],
      cookLocation: json["cookLocation"],
      clientLocation: json["clientLocation"],
      yearsOfExperience: json["yearsOfExperience"],
      cookType: json["cookType"] == null ? [] : List<String>.from(json["cookType"]!.map((x) => x)),
      cookChargePerHr: json["cookChargePerHr"],
      cookmarriageStatus: json["cookmarriageStatus"],
      clientmarriageStatus: json["clientmarriageStatus"],
      cookLanguages: json["cookLanguages"] == null ? [] : List<String>.from(json["cookLanguages"]!.map((x) => x)),
      cookUsername: json["cookUsername"],
      cookReligion: json["cookReligion"],
      cookPhone: json["cookPhone"],
      clientPhone: json["clientPhone"],
      cookProfileImage: json["cookProfileImage"],
      clientProfileImage: json["clientProfileImage"],
      cookCoverImage: json["cookCoverImage"],
      cookHouseAddress: json["cookHouseAddress"],
      clientHouseAddress: json["clientHouseAddress"],
      cookGallery: json["cookGallery"] == null ? [] : List<String>.from(json["cookGallery"]!.map((x) => x)),
      clientSelectedServices: json["clientSelectedServices"] == null ? [] : List<String>.from(json["clientSelectedServices"]!.map((x) => x)),
      clientSelectedSpecialMeals: json["clientSelectedSpecialMeals"] == null ? [] : List<String>.from(json["clientSelectedSpecialMeals"]!.map((x) => x)),
      notes: json["notes"],
      status: json["status"],
      eventstatus: json["eventstatus"],
    );
  }

  Map<String, dynamic> toJson() => {
    "docID": docID,
    "cookID": cookId,
    "clientID": clientId,
    "cookName": cookName,
    "clientName": clientName,
    "cookEmail": cookEmail,
    "clientEmail": clientEmail,
    "cookAbout": cookAbout,
    "cookLocation": cookLocation,
    "clientLocation": clientLocation,
    "yearsOfExperience": yearsOfExperience,
    "cookType": cookType.map((x) => x).toList(),
    "cookChargePerHr": cookChargePerHr,
    "cookmarriageStatus": cookmarriageStatus,
    "clientmarriageStatus": clientmarriageStatus,
    "cookLanguages": cookLanguages.map((x) => x).toList(),
    "cookUsername": cookUsername,
    "cookReligion": cookReligion,
    "cookPhone": cookPhone,
    "clientPhone": clientPhone,
    "cookProfileImage": cookProfileImage,
    "clientProfileImage": clientProfileImage,
    "cookCoverImage": cookCoverImage,
    "cookHouseAddress": cookHouseAddress,
    "clientHouseAddress": clientHouseAddress,
    "cookGallery": cookGallery.map((x) => x).toList(),
    "clientSelectedServices": clientSelectedServices.map((x) => x).toList(),
    "clientSelectedSpecialMeals": clientSelectedSpecialMeals.map((x) => x).toList(),
    "notes":notes,
    "status":status,
    "eventstatus":eventstatus,
  };

  @override
  String toString(){
    return ",$docID,$cookId, $clientId, $cookName, $clientName, $cookEmail, $clientEmail, $cookAbout, $cookLocation, $clientLocation, $yearsOfExperience, $cookType, $cookChargePerHr, $cookmarriageStatus, $clientmarriageStatus, $cookLanguages, $cookUsername, $cookReligion, $cookPhone, $clientPhone, $cookProfileImage, $clientProfileImage, $cookCoverImage, $cookHouseAddress, $clientHouseAddress, $cookGallery, $clientSelectedServices, $clientSelectedSpecialMeals,$notes ,$status ,$eventstatus";
  }
}
