import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_cook/features/location/data/data/repository_impl/location_repository_impl.dart';
import 'package:meta/meta.dart';

import '../data/models/location_payload.dart';
import '../domain/location_repository/location_repository.dart';

part 'enable_loction_event.dart';

part 'enable_loction_state.dart';

class EnableLoctionBloc extends Bloc<EnableLoctionEvent, EnableLoctionState> {
  LocationRepositoryImpl repository;

  EnableLoctionBloc(this.repository) : super(EnableLoctionInitial()) {
    on<EnableLoctionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<EnableMyLocationEvent>(_mapEnableMyLocationEventToState);


  }

  Future<void> _mapEnableMyLocationEventToState(
      EnableMyLocationEvent event, Emitter<EnableLoctionState> emit) async {
    try {
      emit(LocationLoadingState());

      await repository.getAndStoreCurrentLocation();
      emit(LocationSuccessState());
    } catch (e) {
      print(e.toString());
      emit(LocationErrorstate(e.toString()));
    }
  }
  }




