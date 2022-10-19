import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/utils/failure.dart';
import 'package:tvs/domain_tv/usecases_tv/get_popular_tv.dart';
import 'package:tvs/presentation_tv/bloc_tv/popular_tv_bloc.dart';

import '../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_bloc_test.mocks.dart';


@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('the PopularTvEmpty initial state should be empty ', () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'should emits PopularTvLoading state and then PopularTvHasData state when data is successfully fetched..',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    expect: () => <PopularTvState>[
      PopularTvLoading(),
      PopularTvHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetPopularTv.execute()),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should emits PopularTvLoading state and then PopularTvError state when data is failed fetched..',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    expect: () => <PopularTvState>[
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
    verify: (bloc) => PopularTvLoading(),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should emits PopularTvLoading state and then PopularTvEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    expect: () => <PopularTvState>[
      PopularTvLoading(),
      PopularTvEmpty(),
    ],
  );
}
