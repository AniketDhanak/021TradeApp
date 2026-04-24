import '../data/model/watch_list.dart';

abstract class WatchlistEvent {}

/// Load initial data
class LoadWatchlists extends WatchlistEvent {}

/// Change active tab
class SelectWatchlist extends WatchlistEvent {
  final int index;
  SelectWatchlist(this.index);
}

/// Update full watchlist (name + stocks)
class UpdateWatchlist extends WatchlistEvent {
  final int index;
  final Watchlist updatedWatchlist;

  UpdateWatchlist({
    required this.index,
    required this.updatedWatchlist,
  });
}