import 'package:binance_sly/src/common_widgets/time_selection_row.dart';
import 'package:binance_sly/src/features/home/home_screen_viewmodel.dart';
import 'package:binance_sly/src/features/home/widgets/full_chart.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({
    super.key,
  });

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (context, home, _) {
      return SizedBox(
        height: 591.h,
        child: Column(
          children: [
            Gap(18.h),
            const TimeSelectionRow(),
            Expanded(
              child: ListView(children: [
                Gap(18.h),
                const Divider(),
                Gap(17.67.h),
                Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) {
                            return const FullChart();
                          })),
                      child: SvgPicture.asset(
                        'assets/icons/expand.svg',
                        height: 20.h,
                        width: 20.w,
                      ),
                    )),
                Gap(12.67.h),
                Row(
                  children: [
                    const Icon(Icons.arrow_drop_down_circle_outlined),
                    Gap(17.67.w),
                    const Text('BTC/USD'),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "O ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "H ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "L ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "C ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(12.67.h),
                SizedBox(
                  height: 409.h,
                  child: StreamBuilder(
                      stream: home.socket.channel?.stream,
                      builder: (context, snapshot) {
                        home.updateCandlesFromSnapshot(snapshot);
                        return Stack(
                          children: [
                            Hero(
                              tag: 'charts',
                              child: Candlesticks(
                                candles: home.candles,
                                onLoadMoreCandles: home.loadMoreCandles,
                              ),
                            )
                          ],
                        );
                      }),
                )
              ]),
            ),
          ],
        ),
      );
    });
  }
}
