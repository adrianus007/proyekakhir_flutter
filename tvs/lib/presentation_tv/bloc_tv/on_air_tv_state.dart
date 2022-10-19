part of 'on_air_tv_bloc.dart';


@immutable
abstract class OnAirTvState extends Equatable {}

class OnAirTvEmpty extends OnAirTvState {
  @override
  List<Object> get props => [];
}

class OnAirTvLoading extends OnAirTvState {
  @override
  List<Object> get props => [];
}

class OnAirTvError extends OnAirTvState {
  final String message;
  OnAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAirTvData extends OnAirTvState {
  final List<Tv> result;
  OnAirTvData(this.result);

  @override
  List<Object> get props => [result];
}
