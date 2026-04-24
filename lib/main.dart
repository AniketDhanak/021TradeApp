import 'package:diamond_hands_task/screen/watchlist/bloc/watchlist_bloc.dart';
import 'package:diamond_hands_task/screen/watchlist/bloc/watchlist_event.dart';
import 'package:diamond_hands_task/screen/watchlist/presentation/watchlist_screen.dart';
import 'package:diamond_hands_task/utils/app_theme.dart';
import 'package:diamond_hands_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => WatchlistBloc()..add(LoadWatchlists()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utils.defineScreenDimensions(context);
    return MaterialApp(
      title: '021 Trading App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: WatchlistScreen(),
    );
  }
}

