import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../domain_tv/entities_tv/tv.dart';
import '../../domain_tv/usecases_tv/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc
    extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;
  PopularTvBloc(this._getPopularTv)
      : super(PopularTvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());

      final result = await _getPopularTv.execute();

      result.fold(
            (failure) => emit(PopularTvError(failure.message)),
            (data) => data.isNotEmpty
            ? emit(PopularTvHasData(data))
            : emit(PopularTvEmpty()),
      );
    });
  }
}
