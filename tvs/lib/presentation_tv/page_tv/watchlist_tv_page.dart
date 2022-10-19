import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/utils/utils.dart';
import '../bloc_tv/watchlist_tv_bloc.dart';
import '../widgets/tv_card_list.dart';



class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with
    RouteAware{
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () => BlocProvider.of<WatchlistTvBloc>(context).add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BlocProvider.of<WatchlistTvBloc>(context).add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist Tv'),
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state is WatchlistTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvHasData) {
              final tvs = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = tvs[index];
                  return TvCard(tv);
                },
                itemCount: tvs.length,
              );
            } else if (state is WatchlistTvEmpty) {
              return const Center(child: Text('Watchlist is Empty'));
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed to fetch data'),
              );
            }
          },
        ),
      ),
    );
  }
}
