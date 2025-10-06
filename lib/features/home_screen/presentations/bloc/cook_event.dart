part of 'cook_bloc.dart';

sealed class CookEvent extends Equatable {
  const CookEvent();
}


class GetCookEvent extends CookEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
