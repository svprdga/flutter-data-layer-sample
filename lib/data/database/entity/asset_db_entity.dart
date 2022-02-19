class AssetDbEntity {
  static const fieldId = 'id';
  static const fieldSymbol = 'symbol';
  static const fieldName = 'name';
  static const fieldSupply = 'supply';
  static const fieldMaxSupply = 'max_supply';
  static const fieldPriceUsd = 'price_usd';

  final String id;
  final String symbol;
  final String name;
  final double? supply;
  final double? maxSupply;
  final double priceUsd;

  AssetDbEntity({
    required this.id,
    required this.symbol,
    required this.name,
    this.supply,
    this.maxSupply,
    required this.priceUsd,
  });

  AssetDbEntity.fromMap(Map<String, dynamic> map)
      : id = map[fieldId] as String,
        symbol = map[fieldSymbol] as String,
        name = map[fieldName] as String,
        supply = map[fieldSupply] as double?,
        maxSupply = map[fieldMaxSupply] as double?,
        priceUsd = map[fieldPriceUsd] as double;

  Map<String, dynamic> toMap() => {
        fieldId: id,
        fieldSymbol: symbol,
        fieldName: name,
        fieldSupply: supply,
        fieldMaxSupply: maxSupply,
        fieldPriceUsd: priceUsd,
      };
}
