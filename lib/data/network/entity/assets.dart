class AssetsResponse {
  final List<AssetEntity> data;

  AssetsResponse({required this.data});

  factory AssetsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;

    final List<AssetEntity> entities = [];
    for (final element in data) {
      entities.add(AssetEntity.fromJson(element as Map<String, dynamic>));
    }

    return AssetsResponse(data: entities);
  }
}

class AssetEntity {
  final String id;
  final String symbol;
  final String name;
  final String? supply;
  final String? maxSupply;
  final String priceUsd;

  AssetEntity({
    required this.id,
    required this.symbol,
    required this.name,
    this.supply,
    this.maxSupply,
    required this.priceUsd,
  });

  AssetEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        symbol = json['symbol'] as String,
        name = json['name'] as String,
        supply = json['supply'] as String?,
        maxSupply = json['maxSupply'] as String?,
        priceUsd = json['priceUsd'] as String;
}
