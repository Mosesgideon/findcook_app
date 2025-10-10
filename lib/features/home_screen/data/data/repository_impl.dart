import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/cook_onboarding/data/models/cookpayload.dart';
import 'package:find_cook/features/home_screen/data/models/cook_models.dart';

import '../../domain/repo/cooks_repository.dart';

class AllCooksRepositoryImpl extends AllCooksRepository {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'Users',
  );
  final cooks = FirebaseFirestore.instance.collection("Cooks");
  final store = FirebaseFirestore.instance;

  @override
  Future<List<AppCookModelResponse>> getCooks() async {
    try {
      final snapshot = await store.collection("Cooks").get();

      final cooks = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // 🔹 Inject Firestore-generated document ID
        data['docID'] = doc.id;

        print("Firestore Document ID: ${doc.id}");
        print("Cook Data cookID: ${data['cookID']}");

        return AppCookModelResponse.fromJson(data);
      }).toList();

      print("✅ Total cooks fetched: ${cooks.length}");
      return cooks;
    } catch (e) {
      throw Exception("Failed to fetch cooks: $e");
    }
  }



  @override
  Future<void> createCooks(AppCookPayload payload) async {
   await store.collection("Cooks").add(payload.toJson());
    log("Cook added successfully");

  }
}
