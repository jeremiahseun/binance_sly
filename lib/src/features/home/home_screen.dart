// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binance_sly/core/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:binance_sly/src/features/home/home_screen_viewmodel.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';

import 'widgets/charts_page.dart';
import 'widgets/open_order.dart';
import 'widgets/order_book.dart';
import 'widgets/overlay_dropdown.dart';
import 'widgets/top_bar_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeScreenViewModel>(context, listen: false).fetchDetails();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeScreenViewModel>(context, listen: false)
          .startUpdatingBidsAndAsks();
    });
    super.initState();
  }

  @override
  void dispose() {
     Provider.of<HomeScreenViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: SvgPicture.asset(
            themeProvider.isDarkMode
                ? 'assets/icons/white-full-logo.svg'
                : 'assets/icons/full-logo.svg',
            width: 121.w,
            height: 34.h,
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(
                  duration: 1200.ms,
                  delay: 600.ms,
                  color: AppColors.whiteBlackColor(context)),
          centerTitle: false,
          actions: [
            Image.asset(
              'assets/images/dp.png',
              width: 32.w,
              height: 32.h,
            ),
            Gap(18.w),
            SvgPicture.asset(
              'assets/icons/globe.svg',
              width: 24.w,
              height: 34.h,
            ),
            Gap(22.8.w),
            const OverlayDropdown(),
            Gap(20.8.w),
          ]),
      backgroundColor: AppColors.lightGreyColor(context),
      body: Consumer<HomeScreenViewModel>(builder: (context, home, _) {
        return SingleChildScrollView(
            child: Column(
          children: [
            Gap(8.h),
            const TopBarSummary(),
            Gap(8.h),
            Container(
              height: 591.h,
              padding: const EdgeInsets.all(16),
              color: AppColors.whiteBlackColor(context),
              child: Column(children: [
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Container(
                          height: 40.h,
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGreyColor(context)),
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.whiteBlackColor(context)),
                            onTap: (value) {
                              home.tradeTabPage(value);
                            },
                            tabs: [
                              Container(
                                alignment: Alignment.center,
                                height: 34.h,
                                child: Text(
                                  "Charts",
                                  style: AppStyles.black14Medium,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 34.h,
                                child: Text(
                                  "Orderbook",
                                  style: AppStyles.black14Medium,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 34.h,
                                child: Text(
                                  "Recent trades",
                                  style: AppStyles.black14Medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: home.tradeTabController,
                            children: [
                              const ChartsPage(),
                              OrderBook(
                                asks: home.asks,
                                bids: home.bids,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 34.h,
                                child: Text(
                                  "Recent trades",
                                  style: AppStyles.black14Medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Gap(18.h),
            Container(
              height: 510.h,
              color: AppColors.whiteBlackColor(context),
              child: Column(children: [
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            height: 40.h,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.lightGreyColor(context)),
                            child: TabBar(
                              onTap: (value) {
                                home.orderTabPage(value);
                              },
                              indicatorSize: TabBarIndicatorSize.tab,
                              isScrollable: true,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 35.w),
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.whiteBlackColor(context)),
                              tabs: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 34.h,
                                  child: Text(
                                    "Open Orders",
                                    style: AppStyles.black14Medium,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 34.h,
                                  child: Text(
                                    "Positions",
                                    style: AppStyles.black14Medium,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 34.h,
                                  child: Text(
                                    "Order History",
                                    style: AppStyles.black14Medium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: home.orderTabController,
                            children: [
                              const OpenOrderPage(),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Positions",
                                  style: AppStyles.black14Medium,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Order History",
                                  style: AppStyles.black14Medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Gap(39.h),
          ]
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 300))
              .moveX(duration: const Duration(milliseconds: 300)),
        ));
      }),
    );
  }
}
