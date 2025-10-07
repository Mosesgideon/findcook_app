import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_cook/features/mybookings/data/models/book_response.dart';
import 'package:find_cook/features/mybookings/data/models/booking_models.dart';
import 'package:find_cook/features/mybookings/domain/bookingsRepo.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsRepository repository;
  BookingsBloc(this.repository) : super(BookingsInitial()) {
    on<BookingsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<BookCookEvent>(_mapBookCookEventToState);
    on<MyBookingEvent>(_mapMyBookingEventToState);
  }

  Future<void> _mapBookCookEventToState(BookCookEvent event, Emitter<BookingsState> emit
      ) async {

    emit(BookingsLoadingState());
    try {
      var response =await repository.bookCook(event.payload);
      emit(BookingsCookSuccessState());
    } on Exception catch (e) {
      emit(BookingsFailireState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapMyBookingEventToState(MyBookingEvent event, Emitter<BookingsState> emit) async {
emit(BookingsLoadingState());
try {
  var response=await repository.mybookings();
  emit(MyBookingsCookSuccessState(response));
} on Exception catch (e) {
  emit(BookingsFailireState(e.toString()));
  rethrow;
  // TODO
}
  }
}
