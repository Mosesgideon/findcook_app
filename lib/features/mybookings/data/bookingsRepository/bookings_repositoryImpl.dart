import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/mybookings/data/models/book_response.dart';
import 'package:find_cook/features/mybookings/data/models/booking_models.dart';
import 'package:find_cook/features/mybookings/domain/bookingsRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';

 class BookingsRepositoryImpl extends BookingsRepository {
   final CollectionReference bookingsCollection =
   FirebaseFirestore.instance.collection('Bookings');
   final store = FirebaseFirestore.instance;

  @override
  Future<void> bookCook(AppBookingModelPayload payload) async {
    try {
      DocumentReference docRef = bookingsCollection.doc();

      final bookingData = {
        "docID": docRef.id,
        "cookID": payload.cookId,
        "clientID": payload.clientId,
        "cookName": payload.cookName,
        "clientName": payload.clientName,
        "cookEmail": payload.cookEmail,
        "clientEmail": payload.clientEmail,
        "cookAbout": payload.cookAbout,
        "cookLocation": payload.cookLocation,
        "clientLocation": payload.clientLocation,
        "yearsOfExperience": payload.yearsOfExperience,
        "cookType": payload.cookType,
        "cookChargePerHr": payload.cookChargePerHr,
        "cookmarriageStatus": payload.cookmarriageStatus,
        "clientmarriageStatus": payload.clientmarriageStatus,
        "cookLanguages": payload.cookLanguages,
        "cookUsername": payload.cookUsername,
        "cookReligion": payload.cookReligion,
        "cookPhone": payload.cookPhone,
        "clientPhone": payload.clientPhone,
        "cookProfileImage": payload.cookProfileImage,
        "clientProfileImage": payload.clientProfileImage,
        "cookCoverImage": payload.cookCoverImage,
        "cookHouseAddress": payload.cookHouseAddress,
        "clientHouseAddress": payload.clientHouseAddress,
        "cookGallery": payload.cookGallery,
        "clientSelectedServices": payload.clientSelectedServices,
        "clientSelectedSpecialMeals": payload.clientSelectedSpecialMeals,
        "createdAt": FieldValue.serverTimestamp(),
        "notes": payload.notes,
        "status": payload.status,
        "eventstatus": payload.eventstatus,
      };

      // await bookingsCollection.add(bookingData);
      await docRef.set(bookingData);


    } on Exception catch (e) {
      // TODO
      throw Exception("Failed to book cook: $e");

    }


  }

  @override
  Future<List<AppBookingResponse>> mybookings() async {
    final auth = FirebaseAuth.instance.currentUser?.uid;
    if (auth == null) throw Exception("User not logged in");

    final firestore = FirebaseFirestore.instance;

    // Get bookings where user is the client
    final clientSnapshot = await firestore
        .collection("Bookings")
        .where("clientID", isEqualTo: auth)
        .get();

    // Get bookings where user is the cook
    final cookSnapshot = await firestore
        .collection("Bookings")
        .where("cookID", isEqualTo: auth)
        .get();

    // Merge both results
    final allDocs = [...clientSnapshot.docs, ...cookSnapshot.docs];

    // Map to your model
    return allDocs.map((doc) {
      final data = doc.data();
      return AppBookingResponse.fromJson(data);
    }).toList();
  }


   @override
   Future<void> updateMyBooking(String bookingId) async {
     try {
       final firestore = FirebaseFirestore.instance;
       await firestore.collection("Bookings").doc(bookingId).update({
         "status": "accepted",
         "dateAccepted": FieldValue.serverTimestamp(),
       });
     } catch (e) {
       throw Exception("Failed to update booking: $e");

     }
   }



 }