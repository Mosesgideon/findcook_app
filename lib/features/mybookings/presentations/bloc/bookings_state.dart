part of 'bookings_bloc.dart';

sealed class BookingsState extends Equatable {
  const BookingsState();
}

final class BookingsInitial extends BookingsState {
  @override
  List<Object> get props => [];
}

class BookingsLoadingState extends BookingsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class BookingsFailireState extends BookingsState {
  String error;
  BookingsFailireState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
class BookingsCookSuccessState extends BookingsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class MyBookingsCookSuccessState extends BookingsState {
  List<AppBookingResponse> response;
  MyBookingsCookSuccessState(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}