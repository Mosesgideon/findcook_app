import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/authentication/data/models/auth_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/share_prefs/shared_prefs_save.dart';
import '../../domain/repository/auth_repository.dart';
import '../models/AuthSuccessResponse.dart';

class AuthRepositoryImpl extends AuthRepository {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'Users',
  );
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({FirebaseAuth? auth})
    : firebaseAuth = auth ?? FirebaseAuth.instance;
  @override
  Future<AuthSuccessResponse> login(String email, String password) async {
    try {

      var response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw AuthException('Login failed: No user returned.');
      }

      // Fetch additional user data from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        throw AuthException('User data not found in Firestore.');
      }

      final userData = userDoc.data()! as Map<String, dynamic>;

      /// Build AuthSuccessResponse from Firestore data
      final authResponse = AuthSuccessResponse.fromJson({
        ...userData,
        'uid': user.uid,
      });

      /// ✅ Save to SharedPreferences after login
      await SharedPreferencesClass.setUserData(authResponse);

      return AuthSuccessResponse.fromJson({
        ...userData,
        'uid': user.uid,
      });
      // final userData = userDoc.data()! as Map<String, dynamic>;
      //
      //
      // // Build AuthSuccessResponse from Firestore data
      // return AuthSuccessResponse.fromJson({
      //   ...userData,
      //   'uid': user.uid,
      // });
      //

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided.');
      }
      throw AuthException(e.message ?? 'Login failed');
    } catch (e) {
      throw AuthException('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AuthSuccessResponse> register(AuthPayload payload) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: payload.email,
        password: payload.password,
      );

      final userUid = response.user?.uid;

      if (userUid != null) {
        final users = FirebaseFirestore.instance.collection('Users');

        final userData = {
          'uid': userUid,
          'email': payload.email,
          'fullname': payload.fullname,
          'username': payload.username,
          'phone': payload.phone,
          'houseAddress': payload.houseAddress,
          'createdAt': FieldValue.serverTimestamp(),
        };

        // await users.doc(userUid).set(userData);
        //
        // // ✅ Return AuthSuccessResponse using fromJson
        // await SharedPreferencesClass.setUserData(userData);
        //
        // return AuthSuccessResponse.fromJson(userData);

        /// Create AuthSuccessResponse
        final authResponse = AuthSuccessResponse.fromJson(userData);

        /// Save to SharedPreferences
        await SharedPreferencesClass.setUserData(authResponse);

        return AuthSuccessResponse.fromJson(userData);
      } else {
        throw AuthException('User ID not found after registration.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
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
