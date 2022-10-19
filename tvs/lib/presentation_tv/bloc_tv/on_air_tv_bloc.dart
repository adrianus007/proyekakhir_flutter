import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_tv/entities_tv/tv.dart';
import '../../domain_tv/usecases_tv/get_on_air_tv.dart';

part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc
    extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetOnAirTv _getOnAirTvs;
  OnAirTvBloc(this._getOnAirTvs)
      : super(OnAirTvEmpty()) {
    on<OnAirTv>((event, emit) async {
      emit(OnAirTvLoading());

      final result = await _getOnAirTvs.execute();

      result.fold((failure) {
        emit(OnAirTvError(failure.message));
      }, (data) {
        data.isNotEmpty
            ? emit(OnAirTvData(data))
            : emit(OnAirTvEmpty());
      });
    });
  }
}
