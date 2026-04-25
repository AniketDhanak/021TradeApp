import 'package:diamond_hands_task/screen/watchlist/bloc/watchlist_event.dart';
import 'package:diamond_hands_task/screen/watchlist/bloc/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/stock.dart';
import '../data/model/watch_list.dart';
import '../data/dummy/dummy_stocks.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistState.initial()) {
    on<LoadWatchlists>(_onLoadWatchlists);
    on<SelectWatchlist>(_onSelectWatchlist);
    on<UpdateWatchlist>(_onUpdateWatchlist);
    on<ReorderStocksEvent>(_onReorderStocks);
  }

  void _onReorderStocks(
      ReorderStocksEvent event,
      Emitter<WatchlistState> emit,
      ) {
    final updatedWatchlists = List<Watchlist>.from(state.watchlists);

    final currentWatchlist = updatedWatchlists[event.watchlistIndex];

    final updatedStocks = List<Stock>.from(currentWatchlist.stocks);

    int newIndex = event.newIndex;
    if (newIndex > event.oldIndex) newIndex--;

    final item = updatedStocks.removeAt(event.oldIndex);
    updatedStocks.insert(newIndex, item);

    updatedWatchlists[event.watchlistIndex] =
        currentWatchlist.copyWith(stocks: updatedStocks);

    emit(state.copyWith(watchlists: updatedWatchlists));
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