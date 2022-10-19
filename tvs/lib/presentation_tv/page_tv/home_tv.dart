import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/styles/text_styles.dart';
import 'package:movie/utils/constants.dart';
import 'package:search/presentation/pages/search_page_tv.dart';
import 'package:tvs/presentation_tv/page_tv/popular_tv_page.dart';
import 'package:tvs/presentation_tv/page_tv/top_rated_tv_page.dart';
import 'package:tvs/presentation_tv/page_tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import '../../domain_tv/entities_tv/tv.dart';
import '../bloc_tv/on_air_tv_bloc.dart';
import '../bloc_tv/popular_tv_bloc.dart';
import '../bloc_tv/top_rated_tv_bloc.dart';
import 'on_air_page.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/hometv';

  const HomeTvPage({super.key});

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnAirTvBloc>(context).add(OnAirTv());
      BlocProvider.of<PopularTvBloc>(context).add(FetchPopularTv());
      BlocProvider.of<TopRatedTvBloc>(context).add(FetchTopRatedTv());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton Serial Tv'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Sedang Tayang',
                onTap: () => Navigator.pushNamed(context, OnAirPage.ROUTE_NAME),
              ),
              BlocBuilder<OnAirTvBloc, OnAirTvState>(
                builder: (_, state) {
                  if (state is OnAirTvLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is OnAirTvData) {
                    final data = state.result;
                    return TvList(data);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (_, state) {
                  if (state is PopularTvLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PopularTvHasData) {
                    final data = state.result;
                    return TvList(data);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
              builder: (_, state) {
              if (state is TopRatedTvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TopRatedTvHasData) {
                final data = state.result;
                return TvList(data);
              } else {
                return const Text('Failed');
              }
            },
          ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
