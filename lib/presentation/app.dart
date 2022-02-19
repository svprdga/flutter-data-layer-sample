import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_layer_sample/data/database/dao/asset_dao.dart';
import 'package:flutter_data_layer_sample/data/mapper.dart';
import 'package:flutter_data_layer_sample/data/network/client/api_client.dart';
import 'package:flutter_data_layer_sample/data/repository/asset_repository.dart';
import 'package:flutter_data_layer_sample/presentation/main_screen.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final log = Logger(
      printer: PrettyPrinter(),
      level: kDebugMode ? Level.verbose : Level.nothing,
    );

    const String baseUrl = 'https://api.coincap.io/v2/';
    final apiClient = ApiClient(log: log, baseUrl: baseUrl);
    final mapper = Mapper();

    final assetDao = AssetDao();

    final assetRepository = AssetRepository(
      apiClient: apiClient,
      mapper: mapper,
      assetDao: assetDao,
    );

    // ignore: deprecated_member_use
    Sqflite.devSetDebugModeOn(kDebugMode);

    return MultiProvider(
      providers: [
        Provider<Logger>.value(value: log),
        Provider<AssetRepository>.value(value: assetRepository),
      ],
      child: MaterialApp(
        title: 'Data layer sample',
        home: MainScreen(),
      ),
    );
  }
}
