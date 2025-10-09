import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSuccessResponse {
  final User? user;
  final String? userID;
  final String fullname;
  final String email;
  final String username;
  final String phone;
  final String houseAddress;
  final String password;
  final String profileImage;
  final String role;
  final UserLocation location;

  const AuthSuccessResponse({
    this.user,
    this.userID,
    required this.fullname,
    required this.email,
    required this.username,
    required this.phone,
    required this.houseAddress,
    required this.password,
    required this.role,
    required this.profileImage,
    required this.location,
  });

  bool get success => user != null;

  /// Convert to JSON (local storage)
  Map<String, dynamic> toJson() => {
    'uid': userID,
    'email': email,
    'fullname': fullname,
    'username': username,
    'phone': phone,
    'houseAddress': houseAddress,
    'password': password,
    'profileImage': profileImage,
    'location': location.toJson(),
    'role': role,
  };

  /// Convert to Firestore data (adds server timestamp)
  Map<String, dynamic> toFirestoreData() => {
    'uid': userID,
    'email': email,
    'fullname': fullname,
    'username': username,
    'phone': phone,
    'houseAddress': houseAddress,
    'role': role,
    'profileImage': profileImage,
    'location': location.toJson(),
    'createdAt': FieldValue.serverTimestamp(),
  };

  /// Convert to SharedPreferences data (with login state)
  Map<String, dynamic> toSharedPreferencesData() => {
    'uid': userID,
    'email': email,
    'fullname': fullname,
    'username': username,
    'phone': phone,
    'houseAddress': houseAddress,
    'password': password,
    'role': role,
    'profileImage': profileImage,
    'location': location.toJson(),
    'isLoggedIn': true,
  };

  /// Factory constructor: Create from JSON
  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) {
    return AuthSuccessResponse(
      userID: json['uid'],
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      houseAddress: json['houseAddress'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'] ?? '',
      location: json['location'] != null
          ? UserLocation.fromJson(json['location'])
          : UserLocation.empty(),
    );
  }
}

class UserLocation {
  final String address;
  final String latitude;
  final String longitude;
  final String placeName;
  final String locationUpdatedAt;

  UserLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    required this.locationUpdatedAt,
  });

  Map<String, dynamic> toJson() => {
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'place_name': placeName,
    'locationUpdatedAt': locationUpdatedAt,
  };

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      placeName: json['place_name'] ?? '',
      locationUpdatedAt: json['locationUpdatedAt'] ?? '',
    );
  }

  /// Create an empty location
  static UserLocation empty() {
    return UserLocation(
      address: '',
      latitude: '',
      longitude: '',
      placeName: '',
      locationUpdatedAt: '',
    );
  }
}
