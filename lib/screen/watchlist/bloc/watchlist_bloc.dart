import 'package:diamond_hands_task/screen/watchlist/bloc/watchlist_event.dart';
import 'package:diamond_hands_task/screen/watchlist/bloc/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/watch_list.dart';
import '../data/dummy/dummy_stocks.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistState.initial()) {
    on<LoadWatchlists>(_onLoadWatchlists);
    on<SelectWatchlist>(_onSelectWatchlist);
    on<UpdateWatchlist>(_onUpdateWatchlist);
  }

  void _onLoadWatchlists(
      LoadWatchlists event, Emitter<WatchlistState> emit) {
    final watchlists = [
      Watchlist(name: "Watchlist 1", stocks: List.from(dummyStocks)),
      Watchlist(name: "Watchlist 2", stocks: List.from(dummyStocks)),
      Watchlist(name: "Watchlist 3", stocks: List.from(dummyStocks)),
    ];

    emit(state.copyWith(
      watchlists: watchlists,
      isLoading: false,
    ));
  }

  void _onSelectWatchlist(
      SelectWatchlist event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onUpdateWatchlist(
      UpdateWatchlist event, Emitter<WatchlistState> emit) {
    final updatedList = List<Watchlist>.from(state.watchlists);

    updatedList[event.index] = event.updatedWatchlist;

    emit(state.copyWith(watchlists: updatedList));
  }
}