import 'package:flutter_data_layer_sample/data/database/entity/asset_db_entity.dart';
import 'package:flutter_data_layer_sample/data/network/entity/assets.dart';
import 'package:flutter_data_layer_sample/domain/asset.dart';

class MapperException<From, To> implements Exception {
  final String message;

  const MapperException(this.message);

  @override
  String toString() {
    return 'Error when mapping class $From to $To: $message}';
  }
}

class Mapper {
  Asset toAsset(AssetEntity entity) {
    try {
      return Asset(
        id: entity.id,
        symbol: entity.symbol,
        name: entity.name,
        supply: entity.supply != null ? double.parse(entity.supply!) : null,
        maxSupply:
            entity.maxSupply != null ? double.parse(entity.maxSupply!) : null,
        priceUsd: double.parse(entity.priceUsd),
      );
    } catch (e) {
      throw MapperException<AssetEntity, Asset>(e.toString());
    }
  }

  List<Asset> toAssets(List<AssetEntity> entities) {
    final List<Asset> assets = [];

    for (final entity in entities) {
      assets.add(toAsset(entity));
    }

    return assets;
  }

  Asset toAssetFromDb(AssetDbEntity entity) {
    try {
      return Asset(
        id: entity.id,
        symbol: entity.symbol,
        name: entity.name,
        supply: entity.supply,
        maxSupply: entity.maxSupply,
        priceUsd: entity.priceUsd,
      );
    } catch (e) {
      throw MapperException<AssetDbEntity, Asset>(e.toString());
    }
  }

  List<Asset> toAssetsFromDb(List<AssetDbEntity> entities) {
    final List<Asset> assets = [];

    for (final entity in entities) {
      assets.add(toAssetFromDb(entity));
    }

    return assets;
  }

  AssetDbEntity toAssetDbEntity(Asset asset) {
    try {
      return AssetDbEntity(
        id: asset.id,
        symbol: asset.symbol,
        name: asset.name,
        supply: asset.supply,
        maxSupply: asset.maxSupply,
        priceUsd: asset.priceUsd,
      );
    } catch (e) {
      throw MapperException<Asset, AssetDbEntity>(e.toString());
    }
  }

  List<AssetDbEntity> toAssetsDbEntity(List<Asset> assets) {
    final List<AssetDbEntity> list = [];

    for (final asset in assets) {
      list.add(toAssetDbEntity(asset));
    }

    return list;
  }
}
