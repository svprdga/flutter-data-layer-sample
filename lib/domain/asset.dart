class Asset {
  final String id;
  final String symbol;
  final String name;
  final double? supply;
  final double? maxSupply;
  final double priceUsd;

  Asset({
    required this.id,
    required this.symbol,
    required this.name,
    this.supply,
    this.maxSupply,
    required this.priceUsd,
  });
}
