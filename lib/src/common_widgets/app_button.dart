import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onPressed;
  const AppButton({
    Key? key,
    required this.color,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 32.w,
      minWidth: 171.w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: color,
      onPressed: onPressed,
      child: Text(text,
          style: AppStyles.black16Bold
              .copyWith(color: AppColors.whiteColor(context))),
    );
  }
}
