import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/utils/failure.dart';
import 'package:tvs/domain_tv/usecases_tv/get_tv_detail.dart';
import 'package:tvs/presentation_tv/bloc_tv/tv_detail_bloc.dart';

import '../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late TvDetailBloc tvDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });
  test('the TvDetailBloc initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
      'should emits TvDetailLoading state and then TvDetailHasData state when data is successfully fetched.',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(testId)),
      expect: () => <TvDetailState>[
        TvDetailLoading(),
        TvDetailHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testId));
        return FetchTvDetail(testId).props;
      });

  blocTest<TvDetailBloc, TvDetailState>(
    'should emits TvDetailLoading state and TvDetailError when data is failed to fetch.',
    build: () {
      when(mockGetTvDetail.execute(testId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(testId)),
    expect: () => <TvDetailState>[
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) => TvDetailLoading(),
  );
}
