// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:binance_sly/src/common_widgets/app_button.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';

import 'item_selector.dart';

class OpenOrderPage extends StatefulWidget {
  const OpenOrderPage({
    super.key,
  });

  @override
  State<OpenOrderPage> createState() => _OpenOrderPageState();
}

class _OpenOrderPageState extends State<OpenOrderPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Gap(130.h),
        Text("No Open Orders", style: AppStyles.black18Bold),
        Gap(8.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0).w,
          child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
              textAlign: TextAlign.center,
              style: AppStyles.black14Medium),
        ),
        Gap(54.h),
        Container(height: 62.h, color: AppColors.lightGreyColor(context)),
        Container(
            height: 62.w,
            color: AppColors.whiteBlackColor(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    color: AppColors.greenColor(context),
                    text: 'Buy',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          int currentIndex = 0;
                          final pageController = PageController();
                          return StatefulBuilder(builder: (context, setState) {
                            return Container(
                              height: 604.h,
                              width: 390.w,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.whiteBlackColor(context),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40.h,
                                      margin: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.lightGreyColor(
                                              context)),
                                      child: TabBar(
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: BoxDecoration(
                                            border: Border.all(
                                                color: currentIndex == 0
                                                    ? AppColors.greenColor(
                                                        context)
                                                    : AppColors.lightRedColor(
                                                        context)),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.whiteBlackColor(
                                                context)),
                                        onTap: (value) {
                                          currentIndex = value;
                                          setState(() {});
                                          pageController.jumpToPage(value);
                                        },
                                        tabs: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 34.h,
                                            child: Text(
                                              "Buy",
                                              style: AppStyles.black14Medium,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 34.h,
                                            child: Text(
                                              "Sell",
                                              style: AppStyles.black14Medium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: PageView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: pageController,
                                        children: [
                                          ListView(
                                            children: [
                                              Gap(18.h),
                                              const ItemSelector(),
                                              Gap(16.h),
                                              CustomTextField(
                                                  prefix: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Gap(15),
                                                      Text(
                                                        "Limit price",
                                                        style: AppStyles
                                                            .black12Medium
                                                            .copyWith(
                                                          color: AppColors
                                                              .secondaryColor(
                                                                  context),
                                                        ),
                                                      ),
                                                      const Gap(5),
                                                      const Icon(
                                                          Icons.info_outline,
                                                          size: 20),
                                                    ],
                                                  ),
                                                  suffix: const SizedBox()),
                                              Gap(16.h),
                                              CustomTextField(
                                                  prefix: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Gap(15),
                                                      Text(
                                                        "Amount",
                                                        style: AppStyles
                                                            .black12Medium
                                                            .copyWith(
                                                          color: AppColors
                                                              .secondaryColor(
                                                                  context),
                                                        ),
                                                      ),
                                                      const Gap(5),
                                                      const Icon(
                                                          Icons.info_outline,
                                                          size: 20),
                                                    ],
                                                  ),
                                                  suffix: const SizedBox()),
                                              Gap(16.h),
                                              CustomTextField(
                                                  prefix: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Gap(15),
                                                      Text(
                                                        "Type",
                                                        style: AppStyles
                                                            .black12Medium
                                                            .copyWith(
                                                          color: AppColors
                                                              .secondaryColor(
                                                                  context),
                                                        ),
                                                      ),
                                                      const Gap(5),
                                                      const Icon(
                                                          Icons.info_outline,
                                                          size: 20),
                                                    ],
                                                  ),
                                                  suffix: const SizedBox()),
                                              Gap(16.h),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      value: false,
                                                      onChanged: (_) {}),
                                                  Gap(8.w),
                                                  Text("Post Only",
                                                      style: AppStyles
                                                          .black12Medium
                                                          .copyWith(
                                                        color: AppColors
                                                            .secondaryColor(
                                                                context),
                                                      )),
                                                  Gap(6.w),
                                                  const Icon(Icons.info_outline,
                                                      size: 20),
                                                ],
                                              ),
                                              Gap(16.h),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Total",
                                                        style: AppStyles
                                                            .black12Medium
                                                            .copyWith(
                                                          color: AppColors
                                                              .secondaryColor(
                                                                  context),
                                                        )),
                                                    Text("0.00",
                                                        style: AppStyles
                                                            .black12Medium
                                                            .copyWith(
                                                          color: AppColors
                                                              .secondaryColor(
                                                                  context),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Gap(16.h),
                                              Container(
                                                height: 40.w,
                                                width: 321.w,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 34.w),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Color(0xFF483BEB),
                                                      Color(0xFF7847E1),
                                                      Color(0xFFDD568D),
                                                    ],
                                                  ),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    // Button pressed callback
                                                  },
                                                  child: Text(
                                                    'Buy BTC',
                                                    style: AppStyles
                                                        .black14SemiBold
                                                        .copyWith(
                                                            color: AppColors
                                                                .whiteColor(
                                                                    context)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 34.w),
                                                child: Column(
                                                  children: [
                                                    Gap(15.h),
                                                    const Divider(),
                                                    Gap(15.h),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const TitleAmount(
                                                          title:
                                                              "Total account value",
                                                          amount: 0.00,
                                                        ),
                                                        DropdownButton<String>(
                                                            underline:
                                                                const SizedBox(),
                                                            items: const [
                                                              DropdownMenuItem(
                                                                  child: Text(
                                                                      "NGN"))
                                                            ],
                                                            onChanged: (_) {})
                                                      ],
                                                    ),
                                                    Gap(16.h),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: const [
                                                        TitleAmount(
                                                          title: "Open Orders",
                                                          amount: 0.00,
                                                        ),
                                                        TitleAmount(
                                                          title: "Available",
                                                          amount: 0.00,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Gap(32.h),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              AppColors
                                                                  .blueColor(
                                                                      context),
                                                          fixedSize:
                                                              Size(80.w, 32.w)),
                                                  child: Text(
                                                    "Deposit",
                                                    style: AppStyles
                                                        .black14SemiBold
                                                        .copyWith(
                                                            color: AppColors
                                                                .whiteColor(
                                                                    context)),
                                                  ),
                                                ),
                                              ),
                                              Gap(28.h),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 34.h,
                                            child: Text(
                                              "Sell",
                                              style: AppStyles.black14Medium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                  AppButton(
                    color: AppColors.lightRedColor(context),
                    text: 'Sell',
                    onPressed: () {},
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}

class TitleAmount extends StatelessWidget {
  final String title;
  final double amount;
  const TitleAmount({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.black12Medium
              .copyWith(color: AppColors.secondaryColor(context)),
        ),
        Gap(8.h),
        Text(amount.toString(), style: AppStyles.black14Medium),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Widget prefix;
  final String? hintText;
  final Widget suffix;
  const CustomTextField({
    Key? key,
    this.hintText,
    required this.prefix,
    required this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          filled: true,
          fillColor: AppColors.whiteBlackColor(context),
          prefixIcon: prefix,
          suffixIcon: suffix),
    );
  }
}
