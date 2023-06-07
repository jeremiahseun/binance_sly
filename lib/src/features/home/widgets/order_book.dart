import 'package:binance_sly/src/features/home/home_screen_viewmodel.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class OrderItem {
  final double price;
  final double amount;

  OrderItem({required this.price, required this.amount});
}

class OrderBook extends StatefulWidget {
  final List<OrderItem> bids;
  final List<OrderItem> asks;

  const OrderBook({super.key, required this.bids, required this.asks});

  @override
  State<OrderBook> createState() => _OrderBookState();
}

class _OrderBookState extends State<OrderBook> {
  int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (context, home, _) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(26.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    buildItem(0, 'assets/icons/first-order.svg'),
                    Gap(24.w),
                    buildItem(1, 'assets/icons/second-order.svg'),
                    Gap(24.w),
                    buildItem(2, 'assets/icons/third-order.svg'),
                  ],
                ),
                Container(
                  height: 32.w,
                  width: 63.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                      color: AppColors.darkGreyColor(context),
                      borderRadius: BorderRadius.circular(4)),
                  child: DropdownButton(items: const [
                    DropdownMenuItem(child: Text("10")),
                  ], onChanged: (_) {}),
                )
              ],
            ),
            Gap(12.h),
            buildOrderList(home.bids, Colors.red),
            Gap(19.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "36,641.20",
                  style: AppStyles.black16Medium
                      .copyWith(color: AppColors.greenColor(context)),
                ),
                Gap(13.3.h),
                Icon(
                  Icons.arrow_upward_rounded,
                  color: AppColors.greenColor(context),
                ),
                Gap(13.3.h),
                Text(
                  "36,641.20",
                  style: AppStyles.black16Medium,
                ),
              ],
            ),
            Gap(20.h),
            buildOrderList(home.asks, Colors.green, false),
          ],
        ),
      );
    });
  }

  Widget buildItem(int index, String title) {
    bool isSelected = index == selectedItemIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItemIndex = index;
        });
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.darkGreyColor(context)
                : Colors.transparent,
          ),
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            title,
            height: 12.w,
            width: 10.w,
          )),
    );
  }

  Widget buildOrderList(List<OrderItem> orders, Color color,
      [bool showTitle = true]) {
    return Column(
      children: [
        showTitle
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        "Price\n(USDT)",
                        textAlign: TextAlign.left,
                        style: AppStyles.black12Medium
                            .copyWith(color: AppColors.secondaryColor(context)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        "Amount\n(BTC)",
                        textAlign: TextAlign.left,
                        style: AppStyles.black12Medium
                            .copyWith(color: AppColors.secondaryColor(context)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        'Total',
                        textAlign: TextAlign.left,
                        style: AppStyles.black12Medium
                            .copyWith(color: AppColors.secondaryColor(context)),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        showTitle ? const SizedBox(height: 8) : const SizedBox(),
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final order = orders[index];
            return Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.whiteBlackColor(context),
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          order.price.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.whiteBlackColor(context),
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          order.amount.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.whiteBlackColor(context),
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          (order.amount * order.price).toStringAsFixed(2),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width:
                      _calculateFlexValue(order.price, order.amount).toDouble(),
                  color: color.withOpacity(.3),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  int _calculateFlexValue(double volume, double totalVolumn) {
    return (volume / totalVolumn * 390.w).toInt();
  }
}
