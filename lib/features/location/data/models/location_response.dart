class UpdateLocationResponse {
  UpdateLocationResponse({
    required this.id,
    required this.user,
    required this.placeName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  final dynamic? id;
  final dynamic? user;
  final String? placeName;
  final String? address;
  final dynamic? latitude;
  final dynamic? longitude;
  final DateTime? createdAt;

  UpdateLocationResponse copyWith({
    dynamic? id,
    dynamic? user,
    String? placeName,
    String? address,
    dynamic? latitude,
    dynamic? longitude,
    DateTime? createdAt,
  }) {
    return UpdateLocationResponse(
      id: id ?? this.id,
      user: user ?? this.user,
      placeName: placeName ?? this.placeName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UpdateLocationResponse.fromJson(Map<String, dynamic> json) {
    return UpdateLocationResponse(
      id: json["id"],
      user: json["user"],
      placeName: json["place_name"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "place_name": placeName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $user, $placeName, $address, $latitude, $longitude, $createdAt, ";
  }
}
