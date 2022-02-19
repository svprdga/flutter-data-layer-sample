import 'package:flutter_data_layer_sample/data/database/dao/base_dao.dart';
import 'package:flutter_data_layer_sample/data/database/entity/asset_db_entity.dart';

class AssetDao extends BaseDao {
  Future<List<AssetDbEntity>> selectAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(BaseDao.assetTableName);
    return List.generate(maps.length, (i) => AssetDbEntity.fromMap(maps[i]));
  }

  Future<void> insertAll(List<AssetDbEntity> assets) async {
    final db = await getDatabase();
    final batch = db.batch();

    for (final asset in assets) {
      batch.insert(BaseDao.assetTableName, asset.toMap());
    }

    await batch.commit();
  }
}
