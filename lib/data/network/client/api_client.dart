import 'dart:convert';

import 'package:flutter_data_layer_sample/data/network/client/base_client.dart';
import 'package:flutter_data_layer_sample/data/network/entity/assets.dart';
import 'package:logger/logger.dart';

class ApiClient extends BaseClient {
  final String baseUrl;

  ApiClient({
    required Logger log,
    required this.baseUrl,
  }) : super(log: log);

  Future<AssetsResponse> getAssets() async {
    final response = await get(
      '${baseUrl}assets',
      headers: {'Accept-Encoding': 'gzip'},
    );

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 3));

    return AssetsResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
