import 'package:binance_sly/core/sly_socket.dart';
import 'package:binance_sly/models/model.dart';
import 'package:binance_sly/src/utils/constants.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:dio/dio.dart';
import 'package:simple_logger/simple_logger.dart';

import 'interceptors.dart';

class SlyApi {
  final dio = Dio();
  final log = SimpleLogger();
  final socket = SlySocket();

  SlyApi() {
    dio.interceptors.add(DioInterceptor());
    dio.options.sendTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);
    dio.options.baseUrl = AppStrings.baseUrl;
    log.info('Sly Api constructed and DIO setup register');
  }

  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String timeOption,
    int? endTime,
  }) async {
    final uri = '${dio.options.baseUrl}klines';
    final params = {
      'symbol': symbol,
      'interval': timeOption,
      if (endTime != null) 'endTime': endTime.toString(),
    };

    try {
      final res = await dio.get(uri, queryParameters: params);
      final data = res.data as List<dynamic>;
      log.finest('Candles gotten!');
      final candles =
          data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
      log.finest('First candle => ${candles.first}');
      return candles;
    } catch (e) {
      log.severe('Error fetching candles: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<List<SymbolModel>> fetchSymbols() async {
    try {
      final uri = "${dio.options.baseUrl}ticker/price";
      log.info('Fetching symbols with $uri');
      final res = await dio.get(uri);
      log.info('Done with response: ${res.statusCode} and ${res.data}');
      List<dynamic> responseData = res.data;

      // ignore: unnecessary_type_check
      if (responseData is List<dynamic>) {
        final symbolModels = <SymbolModel>[];
        for (final symbolJson in responseData) {
          final symbolModel = SymbolModel.fromJson(symbolJson);
          symbolModels.add(symbolModel);
        }
        return symbolModels.toSet().toList();
      } else {
        throw Exception('Invalid response data type');
      }
    } catch (e) {
      log.shout('Error fetching symbols: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }
}
