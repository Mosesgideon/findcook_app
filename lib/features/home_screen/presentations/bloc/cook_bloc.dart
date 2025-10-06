import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  }

  Future<void> _mapGetCookEventToState(
    GetCookEvent event,
    Emitter<CookState> emit,
  ) async {
    emit(CookLoadingSate());
    try {
      var response = await repositoryImpl.getCooks();
      print(response.length);
      emit(CookSuccessSate(response));
    } on Exception catch (e) {
      // TODO
      emit(CookFailuireSate(e.toString()));
    }
  }
}
