import 'stock.dart';

class Watchlist {
  final String name;
  final List<Stock> stocks;

  Watchlist({
    required this.name,
    required this.stocks,
  });

  Watchlist copyWith({
    String? name,
    List<Stock>? stocks,
  }) {
    return Watchlist(
      name: name ?? this.name,
      stocks: stocks ?? this.stocks,
    );
  }
}