part of 'feeds_bloc.dart';

sealed class FeedsEvent extends Equatable {
  const FeedsEvent();
}

class AddfeedsEvent extends FeedsEvent {
  PostModel model;
  AddfeedsEvent(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [model];
}
