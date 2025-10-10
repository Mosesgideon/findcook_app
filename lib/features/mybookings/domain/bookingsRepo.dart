import 'package:find_cook/features/mybookings/data/models/book_response.dart';

import '../data/models/booking_models.dart';

abstract class BookingsRepository {
  Future<void>bookCook(AppBookingModelPayload payload);
  Future<List<AppBookingResponse>>mybookings();
  Future<void>updateMyBooking(String bookingId,);
}