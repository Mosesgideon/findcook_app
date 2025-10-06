import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_cook/features/mybookings/data/models/booking_models.dart';
import 'package:find_cook/features/mybookings/domain/bookingsRepo.dart';

 class BookingsRepositoryImpl extends BookingsRepository {
   final CollectionReference bookingsCollection =
   FirebaseFirestore.instance.collection('Bookings');
   final store = FirebaseFirestore.instance;
  @override
  Future<void> bookCook(AppBookingModelPayload payload) async {
    try {
      final bookingData = {
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
      };

      await bookingsCollection.add(bookingData);


    } on Exception catch (e) {
      // TODO
      throw Exception("Failed to book cook: $e");

    }


  }

}