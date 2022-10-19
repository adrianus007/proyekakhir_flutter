part of 'tv_recommendations_bloc.dart';

@immutable
abstract class TvRecommendationsEvent extends Equatable {}

class FetchTvRecommendations extends TvRecommendationsEvent {
  final int id;

  FetchTvRecommendations(this.id);

  @override
  List<Object?> get props => [id];
}
