import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/utils/failure.dart';
import 'package:tvs/domain_tv/usecases_tv/get_top_rated_tv.dart';
import 'package:tvs/presentation_tv/bloc_tv/top_rated_tv_bloc.dart';

import '../dummy_data/dummy_objects_tv.dart';
import 'top_rated_tv_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('the TopRatedTvEmpty initial state should be empty ', () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emits PopularTvLoading state and then PopularTvHasData state when data is successfully fetched..',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => <TopRatedTvState>[
      TopRatedTvLoading(),
      TopRatedTvHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTopRatedTv.execute()),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emits TopRatedTvLoading state and then TopRatedTvError state when data is failed fetched..',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => <TopRatedTvState>[
      TopRatedTvLoading(),
      TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvLoading(),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emits TopRatedTvLoading state and then TopRatedTvEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => <TopRatedTvState>[
      TopRatedTvLoading(),
      TopRatedTvEmpty(),
    ],
  );
}
