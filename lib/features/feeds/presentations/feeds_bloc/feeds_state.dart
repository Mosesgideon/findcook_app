part of 'feeds_bloc.dart';

sealed class FeedsState extends Equatable {
  const FeedsState();
}

final class FeedsInitial extends FeedsState {
  @override
  List<Object> get props => [];
}


class FeedsLoadingState extends FeedsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FeedsErrorState extends FeedsState {
  String error;
  FeedsErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}

class AddFeedsSuccessState extends FeedsState {
  PostResponseModel responseModel;
  AddFeedsSuccessState(this.responseModel);
  @override
  // TODO: implement props
  List<Object?> get props => [responseModel];

}