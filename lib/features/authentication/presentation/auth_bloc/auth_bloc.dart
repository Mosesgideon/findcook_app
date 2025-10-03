import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/auth_response.dart';
import '../../domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginEvent>(_mapLoginEventToState);
    on<RegisterEvent>(_mapRegisterEventToState);
  }

  Future<void> _mapLoginEventToState(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthloadingState());
    try {
      await repository.login(event.email, event.password);
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthfailuireState(e.toString()));
      rethrow;
    }
  }

  Future<void> _mapRegisterEventToState(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthloadingState());

    try {
     await repository.register(event.payload);
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthfailuireState(e.toString()));
      rethrow;
    }
  }
}
