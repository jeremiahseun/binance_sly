import 'dart:async';
import 'dart:convert';

import 'package:binance_sly/src/utils/constants.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SlySocket {
  static WebSocketChannel? _channel;
  WebSocketChannel? get channel => _channel;
  static Timer? socketTimer;
  static final log = SimpleLogger();

  static final baseUrl = Uri.parse(AppStrings.baseUrl);

  WebSocketChannel? establishSocketConnection(String symbol, String interval) {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('wss://stream.binance.com:9443/ws'),
      );

      final orderBookEvent = {
        "method": "SUBSCRIBE",
        "params": ["$symbol@depth"],
        "id": 1
      };

      final candleSticksEvent = {
        "method": "SUBSCRIBE",
        "params": ["$symbol@kline_$interval"],
        "id": 1
      };

      channel.sink.add(jsonEncode(orderBookEvent));
      channel.sink.add(jsonEncode(candleSticksEvent));

      return channel;
    } on WebSocketChannelException catch (e) {
      log.severe("Failed to establish WebSocket connection: ${e.message}");
      return null;
    }
  }
}
