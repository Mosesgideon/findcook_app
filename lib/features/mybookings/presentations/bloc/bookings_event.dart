part of 'bookings_bloc.dart';

sealed class BookingsEvent extends Equatable {
  const BookingsEvent();
}

class BookCookEvent extends BookingsEvent {
  AppBookingModelPayload payload;
  BookCookEvent(this.payload);
  @override
  // TODO: implement props
  List<Object?> get props => [payload];
}


class MyBookingEvent extends BookingsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}