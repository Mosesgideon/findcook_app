part of 'cook_bloc.dart';

sealed class CookState extends Equatable {
  const CookState();
}

final class CookInitial extends CookState {
  @override
  List<Object> get props => [];
}
class CookLoadingSate extends CookState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class CookSuccessSate extends CookState {
  List<AppCookModelResponse> response;
  CookSuccessSate(this.response);
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class CookFailuireSate extends CookState {
  String error;
  CookFailuireSate(this.error);
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

