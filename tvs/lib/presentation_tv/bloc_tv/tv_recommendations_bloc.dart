import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../domain_tv/entities_tv/tv.dart';
import '../../domain_tv/usecases_tv/get_tv_recommendations.dart';


part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations _getTvRecommendations;
  TvRecommendationsBloc(this._getTvRecommendations)
      : super(TvRecommendationsEmpty()) {
    on<FetchTvRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvRecommendationsLoading());

      final result = await _getTvRecommendations.execute(id);

      result.fold(
            (failure) => emit(TvRecommendationsError(failure.message)),
            (data) => data.isNotEmpty
            ? emit(TvRecommendationsHasData(data))
            : emit(TvRecommendationsEmpty()),
      );
    });
  }
}
