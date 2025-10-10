import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_cook/features/cook_onboarding/data/models/cookpayload.dart';
import 'package:find_cook/features/home_screen/data/data/repository_impl.dart';

import '../../data/models/cook_models.dart';

part 'cook_event.dart';
part 'cook_state.dart';

class CookBloc extends Bloc<CookEvent, CookState> {
  AllCooksRepositoryImpl repositoryImpl;
  CookBloc(this.repositoryImpl) : super(CookInitial()) {
    on<CookEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetCookEvent>(_mapGetCookEventToState);
    on<AddCookEvent>(_mapGAddCookEventToState);
  }

  Future<void> _mapGetCookEventToState(
    GetCookEvent event,
    Emitter<CookState> emit,
  ) async {
    emit(CookLoadingSate());
    try {
      var response = await repositoryImpl.getCooks();
      print(response.length);
      print(response.first.cookID.toString());
      print("Cook ID: ${response.first.cookID}");


      emit(CookSuccessSate(response));
    } on Exception catch (e) {
      // TODO
      emit(CookFailuireSate(e.toString()));
    }
  }

  FutureOr<void> _mapGAddCookEventToState(
    AddCookEvent event,
    Emitter<CookState> emit,
  ) {
    emit(CookLoadingSate());
    try {
      repositoryImpl.createCooks(event.payload);
      emit(AddCookSccessSate());
    } on Exception catch (e) {
      emit(CookFailuireSate(e.toString()));
      rethrow;
      // TODO
    }
  }
}
