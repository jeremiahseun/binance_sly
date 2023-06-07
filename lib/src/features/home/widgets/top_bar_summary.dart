import 'package:binance_sly/src/features/home/home_screen_viewmodel.dart';
import 'package:binance_sly/src/features/home/widgets/crypto_percent_status.dart';
import 'package:binance_sly/src/utils/enum.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TopBarSummary extends StatelessWidget {
  const TopBarSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (context, home, _) {
      return Container(
        color: AppColors.whiteBlackColor(context),
        child: Column(children: [
          Gap(20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset('assets/images/crypto-logo.png'),
                Gap(8.w),
                DropdownButton<String>(
                  underline: const SizedBox(),
                  icon: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.blackWhiteColor(context),
                      )),
                  value: home.dropdownValue,
                  onChanged: (String? newValue) {
                    home.selectNewDropdownValue(newValue ?? "");
                  },
                  items: home.symbolDropDownList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: AppStyles.black18Medium),
                    );
                  }).toList(),
                ),
                Gap(27.w),
                Text("\$20,634",
                        style: AppStyles.black18Medium
                            .copyWith(color: AppColors.greenColor(context)))
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 300.ms)
              ],
            ),
          ),
          Gap(18.h),
          SizedBox(
            height: 50.h,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              scrollDirection: Axis.horizontal,
              children: [
                const CryptoPercentStatus(
                  icon: Icons.access_time,
                  hrState: 'change',
                  amount: "520.80 +1.25%",
                  status: CryptoPercentAmountStatus.increased,
                ),
                Gap(11.w),
                VerticalDivider(
                  color: AppColors.secondaryColor(context),
                ),
                Gap(16.w),
                const CryptoPercentStatus(
                  icon: Icons.arrow_upward_outlined,
                  hrState: 'high',
                  amount: "520.80 +1.25%",
                  status: CryptoPercentAmountStatus.normal,
                ),
                Gap(11.w),
                VerticalDivider(
                  color: AppColors.secondaryColor(context),
                ),
                Gap(16.w),
                const CryptoPercentStatus(
                  icon: Icons.arrow_downward_outlined,
                  hrState: 'low',
                  amount: "520.80 +1.25%",
                  status: CryptoPercentAmountStatus.normal,
                ),
              ]
                  .animate(delay: 300.ms, interval: 100.ms)
                  .fadeIn(duration: 300.ms),
            ),
          ),
          Gap(16.h),
        ]),
      );
    });
  }
}
