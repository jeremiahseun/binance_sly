import 'package:binance_sly/src/utils/enum.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CryptoPercentStatus extends StatelessWidget {
  final String amount;
  final CryptoPercentAmountStatus status;
  final IconData icon;
  final String hrState;
  const CryptoPercentStatus({
    Key? key,
    required this.amount,
    required this.status,
    required this.icon,
    required this.hrState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13.33.w, color: AppColors.secondaryColor(context)),
            Gap(5.33.w),
            Text(
              "24h $hrState",
              style: AppStyles.black12Medium
                  .copyWith(color: AppColors.secondaryColor(context)),
            )
          ],
        ),
        Gap(4.h),
        Text(
          amount,
          style: AppStyles.black14Medium.copyWith(
              color: status == CryptoPercentAmountStatus.increased
                  ? AppColors.greenColor(context)
                  : status == CryptoPercentAmountStatus.decreased
                      ? AppColors.redColor(context)
                      : AppColors.secondaryColor(context)),
        )
      ],
    );
  }
}
