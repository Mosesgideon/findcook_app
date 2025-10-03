import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/authentication/data/models/auth_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'hire-cook-users',
  );
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? auth})
    : firebaseAuth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided.');
      }
      throw AuthException(e.message ?? 'Login failed');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> register(AuthPayload payload) async {
    try
    {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: payload.email,
        password: payload.password,
      );
      final userUid = response.user?.uid;

      if (userUid != null) {
        final users = FirebaseFirestore.instance.collection('Users');


        await users.doc(userUid).set({
          'uid': userUid,
          'email': payload.email,
          'fullname': payload.fullname,
          'username': payload.username,
          'phone': payload.phone,
          'houseAddress': payload.houseAddress,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

    } on FirebaseAuthException catch (e)
    {
      if (e.code == 'weak-password') {
        throw AuthException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('The account already exists for that email.');
      }
      else if (e.code == 'invalid-email') {
        throw AuthException('The email address is not valid.');
      }
      throw AuthException(e.message ?? 'Registration failed');
    } catch (e) {
      throw AuthException('Registration failed: $e');
    }
  }

  @override
  Future<void> resetpassword(String email) {
    // TODO: implement resetpassword
    throw UnimplementedError();
  }
}



@override
Future<void> resetpassword(String email) {
  // TODO: implement resetpassword
  throw UnimplementedError();
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
