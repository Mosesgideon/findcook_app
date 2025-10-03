part of 'enable_loction_bloc.dart';

@immutable
abstract class EnableLoctionState extends Equatable {}

class EnableLoctionInitial extends EnableLoctionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LocationLoadingState extends EnableLoctionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LocationErrorstate extends EnableLoctionState {
  String error;

  LocationErrorstate(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class LocationSuccessState extends EnableLoctionState {

  LocationSuccessState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

