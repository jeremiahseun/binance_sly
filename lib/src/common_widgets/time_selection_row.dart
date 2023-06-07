// ignore_for_file: library_private_types_in_public_api

import 'package:binance_sly/src/features/home/home_screen_viewmodel.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TimeSelectionRow extends StatefulWidget {
  const TimeSelectionRow({super.key});

  @override
  _TimeSelectionRowState createState() => _TimeSelectionRowState();
}

class _TimeSelectionRowState extends State<TimeSelectionRow> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (context, home, _) {
      return Row(
        children: [
          Text(
            "Time",
            style: AppStyles.black14Medium,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Gap(28.w),
                  for (int i = 0; i < home.timeOptions.length; i++)
                    InkWell(
                      onTap: () {
                        home.selectNewTimeOption(i);
                      },
                      child: AnimatedContainer(
                        curve: Curves.easeOutQuad,
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: home.selectedTimeOptionIndex == i
                                ? AppColors.darkGreyColor(context)
                                : AppColors.whiteBlackColor(context)),
                        child: Text(home.timeOptions[i],
                            style: home.selectedTimeOptionIndex == i
                                ? AppStyles.black14Medium
                                : AppStyles.black14Medium.copyWith(
                                    color: AppColors.secondaryColor(context))),
                      ),
                    ),
                  Gap(16.5.w),
                  DropdownButton<String>(
                    underline: const SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    value: home.timeOptions[home.selectedTimeOptionIndex],
                    onChanged: (String? newValue) {
                      setState(() {
                        home.selectedTimeOptionIndex =
                            home.timeOptions.indexOf(newValue!);
                      });
                    },
                    items: home.timeOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  Gap(8.47.w),
                  VerticalDivider(
                    color: AppColors.secondaryColor(context),
                    thickness: 10,
                  ),
                  Gap(5.25.w),
                  SvgPicture.asset('assets/icons/candle-chart.svg'),
                  Gap(8.47.w),
                  VerticalDivider(
                    color: AppColors.secondaryColor(context),
                    thickness: 10,
                  ),
                  Gap(5.25.w),
                  SvgPicture.asset('assets/icons/fx.svg'),
                  Gap(5.25.w),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
