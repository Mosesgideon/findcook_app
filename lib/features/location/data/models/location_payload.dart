class UpdateLocationPayload {
  UpdateLocationPayload({
    required this.placeName,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String? placeName;
  final String? address;
  final String? latitude;
  final String? longitude;

  UpdateLocationPayload copyWith({
    String? placeName,
    String? address,
    String? latitude,
    String? longitude,
  }) {
    return UpdateLocationPayload(
      placeName: placeName ?? this.placeName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory UpdateLocationPayload.fromJson(Map<String, dynamic> json) {
    return UpdateLocationPayload(
      placeName: json["place_name"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "place_name": placeName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };

  @override
  String toString() {
    return "$placeName, $address, $latitude, $longitude, ";
  }
}
