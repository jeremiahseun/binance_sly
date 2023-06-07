part of model;

class SymbolModel {
  final String symbol;
  final num price;

  SymbolModel({required this.symbol, required this.price});

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(
      symbol: json['symbol'],
      price: num.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
    };
  }
}
