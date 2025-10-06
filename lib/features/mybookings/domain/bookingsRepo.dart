import '../data/models/booking_models.dart';

abstract class BookingsRepository {
  Future<void>bookCook(AppBookingModelPayload payload);
}