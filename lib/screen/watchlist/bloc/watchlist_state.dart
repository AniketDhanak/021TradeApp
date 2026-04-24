import '../data/model/watch_list.dart';

class WatchlistState {
  final List<Watchlist> watchlists;
  final int selectedIndex;
  final bool isLoading;

  WatchlistState({
    required this.watchlists,
    required this.selectedIndex,
    this.isLoading = false,
  });

  factory WatchlistState.initial() {
    return WatchlistState(
      watchlists: [],
      selectedIndex: 0,
      isLoading: true,
    );
  }

  WatchlistState copyWith({
    List<Watchlist>? watchlists,
    int? selectedIndex,
    bool? isLoading,
  }) {
    return WatchlistState(
      watchlists: watchlists ?? this.watchlists,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}