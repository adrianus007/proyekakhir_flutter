part of 'watchlist_tv_bloc.dart';

@immutable
abstract class WatchlistTvEvent extends Equatable {}

class FetchWatchlistTv extends WatchlistTvEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistStatus extends WatchlistTvEvent {
  final int id;
  FetchWatchlistStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AddTvToWatchlist extends WatchlistTvEvent {
  final TvDetail tv;
  AddTvToWatchlist(this.tv);
  @override
  List<Object?> get props => [tv];
}

class RemoveTvFromWatchlist extends WatchlistTvEvent {
  final TvDetail tv;
  RemoveTvFromWatchlist(this.tv);
  @override
  List<Object?> get props => [tv];
}
