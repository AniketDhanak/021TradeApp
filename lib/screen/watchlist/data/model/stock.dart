import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final String name;
  final double price;
  final double change;

  const Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });

  /// Copy with (useful for updates later)
  Stock copyWith({
    String? symbol,
    String? name,
    double? price,
    double? change,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      price: price ?? this.price,
      change: change ?? this.change,
    );
  }

  /// Convert from JSON (future API-ready)
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'price': price,
      'change': change,
    };
  }

  @override
  List<Object> get props => [symbol, name, price, change];
}