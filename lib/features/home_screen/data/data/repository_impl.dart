

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/home_screen/data/models/cook_models.dart';

import '../../domain/repo/cooks_repository.dart';

class AllCooksRepositoryImpl extends AllCooksRepository{
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'Users',
  );
  final store = FirebaseFirestore.instance;
  @override
  Future<List<AppCookModelResponse>> getCooks() async {
    try {
      final snapshot = await store.collection("Cooks").get();

      final cooks = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("Cook data: $data"); // 👀 check here
        return AppCookModelResponse.fromJson({...data, 'cookID': doc.id});
      }).toList();
      print(cooks.length);
      return cooks;

    } catch (e) {
      throw Exception("Failed to fetch cooks: $e");
    }
  }

}