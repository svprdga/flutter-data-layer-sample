import 'package:flutter_data_layer_sample/data/database/dao/asset_dao.dart';
import 'package:flutter_data_layer_sample/data/mapper.dart';
import 'package:flutter_data_layer_sample/data/network/client/api_client.dart';
import 'package:flutter_data_layer_sample/domain/asset.dart';

class AssetRepository {
  final ApiClient apiClient;
  final Mapper mapper;
  final AssetDao assetDao;

  AssetRepository({
    required this.apiClient,
    required this.mapper,
    required this.assetDao,
  });

  Future<List<Asset>> getAssets() async {
    // First, try to fetch the assets from database
    final dbEntities = await assetDao.selectAll();

    if (dbEntities.isNotEmpty) {
      return mapper.toAssetsFromDb(dbEntities);
    }

    // if the database is empty, fetch from the API, saved it to database,
    // and return it to the caller
    final response = await apiClient.getAssets();
    final assets = mapper.toAssets(response.data);

    await assetDao.insertAll(mapper.toAssetsDbEntity(assets));

    return assets;
  }
}
