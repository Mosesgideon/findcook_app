import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_cook/features/feeds/data/models/postmodels.dart';
import 'package:find_cook/features/feeds/domain/feeds_repository.dart';

import '../../data/models/postresponse.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  FeedsRepository repository;

  FeedsBloc(this.repository) : super(FeedsInitial()) {
    on<FeedsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddfeedsEvent>(_mapAddfeedsEventToState);
  }

  Future<void> _mapAddfeedsEventToState(
    AddfeedsEvent event,
    Emitter<FeedsState> emit,
  ) async {
    emit(FeedsLoadingState());
    try {
      var response = await repository.postfeeds(event.model);
      emit(AddFeedsSuccessState(response));
    } on Exception catch (e) {
      emit(FeedsErrorState(e.toString()));
      rethrow;
      // TODO
    }
  }
}
