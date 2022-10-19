import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/now_playing_movie_bloc.dart';


class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-movie';

  @override
  _NowPlayingMoviesPageState createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<NowPlayingMovieBloc>(context)
            .add(OnNowPlayingMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
          builder: (context, state) {
            if (state is NowPlayingMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            }
            else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }

          },
        ),
      ),
    );
  }
}
