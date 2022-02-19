import 'package:flutter/widgets.dart';
import 'package:flutter_data_layer_sample/data/database/entity/asset_db_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDao {
  static const databaseName = 'data-layer-sample.db';

  static const assetTableName = 'asset';

  @protected
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createAssetTable(batch);
        await batch.commit();
      },
      version: 1,
    );
  }

  void _createAssetTable(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE $assetTableName(
      ${AssetDbEntity.fieldId} TEXT PRIMARY KEY NOT NULL,
      ${AssetDbEntity.fieldSymbol} TEXT NOT NULL,
      ${AssetDbEntity.fieldName} TEXT NOT NULL,
      ${AssetDbEntity.fieldSupply} REAL,
      ${AssetDbEntity.fieldMaxSupply} REAL,
      ${AssetDbEntity.fieldPriceUsd} REAL NOT NULL
      );
      ''',
    );
  }
}
