import 'package:binance_sly/src/features/home/home_screen_viewmodel.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullChart extends StatelessWidget {
  const FullChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<HomeScreenViewModel>(builder: (context, home, _) {
        return Hero(
          tag: 'charts',
          child: Candlesticks(
            candles: home.candles,
            onLoadMoreCandles: home.loadMoreCandles,
            actions: [
              ToolBarAction(child: const Text("Tool"), onPressed: () {})
            ],
          ),
        );
      }),
    );
  }
}
