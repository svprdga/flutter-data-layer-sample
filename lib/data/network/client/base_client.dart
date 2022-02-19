import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class BaseClient {
  static const _timeout = 30000;
  static const _retries = 1;

  final Logger log;
  late final http.Client _client;

  BaseClient({required this.log}) {
    _client = http.Client();
  }

  @protected
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    int? currentTry,
    Map<String, dynamic>? queryParameters,
  }) async {
    int retry = currentTry ?? 0;

    String queryParams = '';
    if (queryParameters != null) {
      queryParams += '?';
      queryParameters.forEach((key, value) {
        queryParams += '$key=$value&';
      });
      queryParams = queryParams.substring(0, queryParams.length - 1);
    }

    try {
      final uri = Uri.parse('$url$queryParams');
      return await _client
          .get(uri, headers: headers)
          .timeout(const Duration(milliseconds: _timeout));
    } on TimeoutException catch (_) {
      log.w("Timeout after $_timeout milliseconds:");
      log.w("-- URI: $url");

      if (retry < _retries) {
        retry++;
        return get(url, headers: headers, currentTry: retry);
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
