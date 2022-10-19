import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/utils/failure.dart';
import 'package:tvs/domain_tv/usecases_tv/get_on_air_tv.dart';
import 'package:tvs/presentation_tv/bloc_tv/on_air_tv_bloc.dart';

import '../dummy_data/dummy_objects_tv.dart';
import 'on_air_tv_bloc_test.mocks.dart';


@GenerateMocks([GetOnAirTv])
void main() {
  late MockGetOnAirTv mockGetOnAirTv;
  late OnAirTvBloc onAirTvBloc;

  setUp(() {
    mockGetOnAirTv = MockGetOnAirTv();
    onAirTvBloc = OnAirTvBloc(mockGetOnAirTv);
  });

  test('the OnTheAirTvBloc initial state should be empty ', () {
    expect(onAirTvBloc.state, OnAirTvEmpty());
  });

  blocTest<OnAirTvBloc, OnAirTvState>(
      'should emits NowPlayingTvLoading() state and then OnTheAirTvHasData state when data is successfully fetched..',
      build: () {
        when(mockGetOnAirTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return onAirTvBloc;
      },
      act: (bloc) => bloc.add(OnAirTv()),
      expect: () => <OnAirTvState>[
        OnAirTvLoading(),
        OnAirTvData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTv.execute());
        return OnAirTv().props;
      });

  blocTest<OnAirTvBloc, OnAirTvState>(
    'should emits NowPlayingTvLoading() state and then OnTheAirTvError state when data is failed fetched..',
    build: () {
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(OnAirTv()),
    expect: () => <OnAirTvState>[
      OnAirTvLoading(),
      OnAirTvError('Server Failure'),
    ],
    verify: (bloc) => OnAirTvLoading(),
  );

  blocTest<OnAirTvBloc, OnAirTvState>(
    'should emits NowPlayingTvLoading state and then NowPlayingTvEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => const Right([]));
      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(OnAirTv()),
    expect: () => <OnAirTvState>[
      OnAirTvLoading(),
      OnAirTvEmpty(),
    ],
  );
}
