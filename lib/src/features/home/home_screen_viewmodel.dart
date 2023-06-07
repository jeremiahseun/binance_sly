import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:binance_sly/core/sly_api.dart';
import 'package:binance_sly/core/sly_socket.dart';
import 'package:binance_sly/models/model.dart';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:simple_logger/simple_logger.dart';

import 'widgets/order_book.dart';

class HomeScreenViewModel with ChangeNotifier {
  String dropdownValue = 'USDT/BTC';
  final log = SimpleLogger();
  final socket = SlySocket();
  Stream<dynamic>? stream;
  StreamSubscription<dynamic>? streamSubscription;
  PageController orderTabController = PageController();
  PageController tradeTabController = PageController();
  int selectedTimeOptionIndex = 0;
  int orderBookAccount = 10;
  String currentSymbol = '';
  String currentTimeOption = '1H';
  List<String> symbols = [];
  List<String> symbolDropDownList = ['USDT/BTC', 'BTC/USDT', 'USDT/USD'];
  List<SymbolModel> symbolModelList = [];
  List<Candle> candles = [];
  List<String> timeOptions = [
    '1H',
    '2H',
    '4H',
    '1D',
    '1W',
    '1M',
  ];

  void changeOrderBookCount(int index) {
    orderBookAccount = index;
    notifyListeners();
  }

  void selectNewTimeOption(int value) {
    selectedTimeOptionIndex = value;
    fetchCandles(newTimeOption: timeOptions[value].toLowerCase());
    notifyListeners();
  }

  void selectNewDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  void orderTabPage(int value) {
    orderTabController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }

  void tradeTabPage(int value) {
    tradeTabController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }

  Future fetchDetails() async {
    await fetchSymbols();
    await fetchCandles();
  }

  Future<List<String>> fetchSymbols() async {
    try {
      symbolModelList = await SlyApi().fetchSymbols();
      final symbolList = <String>[];
      for (final symbolModel in symbolModelList) {
        symbolList.add(symbolModel.symbol);
      }

      if (symbolList.isNotEmpty) {
        log.finest('JUST SYMBOLS \n${symbolList.toList()}');
        currentSymbol = symbolList[0];
        return symbolList;
      } else {
        return [];
      }
    } catch (e) {
      log.shout('Error fetching symbols: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<void> fetchCandles({String? newSymbol, String? newTimeOption}) async {
    log.info('Fetching Candles');
    final fetchedCandles = await SlyApi().fetchCandles(
        symbol: newSymbol ?? currentSymbol,
        timeOption: newTimeOption ?? timeOptions.first.toLowerCase());
    log.info('Done Fetching Candles');
    connectToSocket(newSymbol ?? currentSymbol,
        newTimeOption ?? timeOptions.first.toLowerCase());
    log.info('Socket connecting');
    candles = fetchedCandles;
    currentTimeOption = newTimeOption ?? timeOptions.first.toLowerCase();
    currentSymbol = newSymbol ?? currentSymbol;
    log.info('All done');
    notifyListeners();
  }

  void connectToSocket(String symbol, String interval) {
    final channel = socket.establishSocketConnection(symbol, interval);
    stream = channel?.stream;
    if (channel != null) {
      streamSubscription?.cancel();
      streamSubscription = channel.stream.listen(
        (data) {
          log.info("Stream gotten with ${data.toString()}");
        },
        onError: (error) {
          log.severe(error.toString());
        },
        onDone: () {
          log.info("Stream closed");
        },
      );
    }
  }

  @override
  void dispose() {
    log.info("Stream disposed");
    streamSubscription?.cancel();
    super.dispose();
  }

  void updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
    log.info('Updating candles');
    if (candles.isEmpty || snapshot.data == null) {
      return;
    }

    try {
      final map = jsonDecode(snapshot.data! as String) as Map<String, dynamic>;
      if (map.containsKey('k')) {
        final candleTicker = CandleTickerModel.fromJson(map);

        if (candles[0].date == candleTicker.candle.date &&
            candles[0].open == candleTicker.candle.open) {
          // Update last candle
          candles[0] = candleTicker.candle;
          log.info('Updating last candles');
        } else if (candleTicker.candle.date.difference(candles[0].date) ==
            candles[0].date.difference(candles[1].date)) {
          // Add new candle to the list
          candles.insert(0, candleTicker.candle);
          log.info('Adding new candles');
        }
      }
    } catch (e) {
      log.severe('Error updating candles from snapshot: $e');
      // Handle the error accordingly
    }
  }

  Future<void> loadMoreCandles() async {
    log.info('loading more candles');
    try {
      final data = await SlyApi().fetchCandles(
        symbol: currentSymbol,
        timeOption: currentTimeOption,
        endTime: candles.last.date.millisecondsSinceEpoch,
      );
      candles.removeLast();
      candles.addAll(data);
      notifyListeners();
    } catch (e) {
      log.severe('Error loading more candles: $e');
      // Handle the error accordingly
    }
  }

  ///? AUTOMATED CODE

  List<OrderItem> generateRandomOrderItems() {
    final random = Random();
    final List<OrderItem> orderItems = [];

    for (int i = 0; i < orderBookAccount / 2; i++) {
      final price = random.nextDouble() *
          0.1; // Generate a random price between 0 and 0.1
      final amount =
          random.nextInt(90) + 1; // Generate a random amount between 1 and 20
      orderItems.add(OrderItem(price: price, amount: amount.toDouble()));
    }
    log.info(orderItems.length);
    return orderItems;
  }

  List<OrderItem> bids = [];
  List<OrderItem> asks = [];

  void startUpdatingBidsAndAsks() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      bids = generateRandomOrderItems();
      asks = generateRandomOrderItems();
      log.info("BIDS ${bids.first.amount} ${bids.first.price}");
      log.info("ASKS ${asks.first.amount} ${asks.first.price}");
      notifyListeners();
    });
  }
}
