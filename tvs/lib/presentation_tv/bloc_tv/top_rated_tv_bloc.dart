import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain_tv/entities_tv/tv.dart';
import '../../domain_tv/usecases_tv/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc
    extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;
  TopRatedTvBloc(this._getTopRatedTv)
      : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold(
            (failure) => emit(TopRatedTvError(failure.message)),
            (data) => data.isNotEmpty
            ? emit(TopRatedTvHasData(data))
            : emit(TopRatedTvEmpty()),
      );
    });
  }
}
