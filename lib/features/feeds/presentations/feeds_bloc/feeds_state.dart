part of 'feeds_bloc.dart';

sealed class FeedsState extends Equatable {
  const FeedsState();
}

final class FeedsInitial extends FeedsState {
  @override
  List<Object> get props => [];
}
