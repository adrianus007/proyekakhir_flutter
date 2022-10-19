part of 'now_playing_movie_bloc.dart';


@immutable
abstract class NowPlayingMovieEvent extends Equatable {}

class OnNowPlayingMovie extends NowPlayingMovieEvent {
  @override
  List<Object> get props => [];
}
