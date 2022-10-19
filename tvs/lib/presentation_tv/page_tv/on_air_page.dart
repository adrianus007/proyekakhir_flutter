import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc_tv/on_air_tv_bloc.dart';
import '../widgets/tv_card_list.dart';

class OnAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/on_air-tv';

  const OnAirPage({super.key});

  @override
  _OnAirPageState createState() => _OnAirPageState();
}

class _OnAirPageState extends State<OnAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
        BlocProvider.of<OnAirTvBloc>(context).add(OnAirTv());
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sedang Tayang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        )
      ),
    );
  }
}
