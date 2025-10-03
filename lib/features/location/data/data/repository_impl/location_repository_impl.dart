import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/location/data/models/location_payload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/location_repository/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'Users',
  );
  final FirebaseAuth firebaseAuth;

  LocationRepositoryImpl({FirebaseAuth? auth})
      : firebaseAuth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> storelocation(UpdateLocationPayload payload) async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Update user document with location data
      await users.doc(currentUser.uid).update({
        'location': payload.toJson(),
        'locationUpdatedAt': FieldValue.serverTimestamp(),
      });

    } on FirebaseException catch (e) {
      throw Exception('Failed to update location: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update location: $e');
    }
  }

  Future<void> getAndStoreCurrentLocation() async {
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      Placemark? place;
      try {
        // Get placemarks from coordinates
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          place = placemarks.first;
          print('📍 Place found: ${place.locality}, ${place.country}');
        }
      } catch (e) {
        print('Geocoding error: $e');
      }

      // Create location payload using the actual place data
      final locationPayload = UpdateLocationPayload(
        placeName: place?.locality ?? "Unknown Location",
        address: _formatAddress(place),
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );

      print('💾 Storing location:');
      print('  Place Name: ${locationPayload.placeName}');
      print('  Address: ${locationPayload.address}');
      print('  Latitude: ${locationPayload.latitude}');
      print('  Longitude: ${locationPayload.longitude}');

      // Store location
      await storelocation(locationPayload);

    } catch (e) {
      throw Exception('Failed to get and store location: $e');
    }
  }

  String _formatAddress(Placemark? place) {
    if (place == null) return "Unknown Address";

    return [
      place.street,
      place.subLocality,
      place.locality,
      place.country
    ].where((part) => part != null && part!.isNotEmpty).join(", ");
  }

  // Method to get stored location
  Future<UpdateLocationPayload?> getStoredLocation() async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        return null;
      }

      final userDoc = await users.doc(currentUser.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data() as Map<String, dynamic>;

        if (userData.containsKey('location')) {
          final locationData = userData['location'] as Map<String, dynamic>;
          return UpdateLocationPayload.fromJson(locationData);
        }
      }

      return null;
    } catch (e) {
      throw Exception('Failed to get stored location: $e');
    }
  }
}
