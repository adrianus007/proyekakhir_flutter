import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/utils/failure.dart';
import 'package:tvs/domain_tv/usecases_tv/get_tv_recommendations.dart';
import 'package:tvs/presentation_tv/bloc_tv/tv_recommendations_bloc.dart';

import '../dummy_data/dummy_objects_tv.dart';
import 'tv_recommendations_bloc_test.mocks.dart';


@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendations;
  late TvRecommendationsBloc tvRecommendationsBloc;

  const testId = 1;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationsBloc =
        TvRecommendationsBloc(mockGetTvRecommendations);
  });

  test('the TvRecommendationsEmpty initial state should be empty ', () {
    expect(tvRecommendationsBloc.state, TvRecommendationsEmpty());
  });

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'should emits PopularTvLoading state and then PopularTvHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTvRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(testId)),
    expect: () => <TvRecommendationsState>[
      TvRecommendationsLoading(),
      TvRecommendationsHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTvRecommendations.execute(testId)),
  );

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'should emits TvRecommendationsLoading state and then TvRecommendationsError state when data is failed fetched..',
    build: () {
      when(mockGetTvRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(testId)),
    expect: () => <TvRecommendationsState>[
      TvRecommendationsLoading(),
      TvRecommendationsError('Server Failure'),
    ],
    verify: (bloc) => TvRecommendationsLoading(),
  );

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'should emits TvRecommendationsLoading state and then TvRecommendationsEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTvRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(testId)),
    expect: () => <TvRecommendationsState>[
      TvRecommendationsLoading(),
      TvRecommendationsEmpty(),
    ],
  );
}
