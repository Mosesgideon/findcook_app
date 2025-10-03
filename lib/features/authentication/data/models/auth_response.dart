import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPayload {
  final User? user;
  final String? userID;
  final String fullname;
  final String email;
  final String username;
  final String phone;
  final String houseAddress;
  final String password;

  const AuthPayload({
    this.user,
     this.userID,
    required this.fullname,
    required this.email,
    required this.username,
    required this.phone,
    required this.houseAddress,
    required this.password,
  });

  bool get success => user != null;

  Map<String, dynamic> toJson() => {
    'uid': userID,
    'email': email,
    'fullname': fullname,
    'username': username,
    'phone': phone,
    'houseAddress': houseAddress,
    // Remove password from JSON - never store passwords in database
  };

  // Optional: Create a method for Firestore data (without password)
  Map<String, dynamic> toFirestoreData() => {
    'uid': userID,
    'email': email,
    'fullname': fullname,
    'username': username,
    'phone': phone,
    'houseAddress': houseAddress,
    'createdAt': FieldValue.serverTimestamp(),
  };
}