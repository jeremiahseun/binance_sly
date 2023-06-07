// ignore_for_file: library_private_types_in_public_api

import 'package:binance_sly/core/theme_provider.dart';
import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OverlayDropdown extends StatefulWidget {
  const OverlayDropdown({super.key});

  @override
  _OverlayDropdownState createState() => _OverlayDropdownState();
}

class _OverlayDropdownState extends State<OverlayDropdown> {
  final List<String> dropdownItems = [
    'Exchange',
    'Wallets',
    'Roqqu Hub',
    'Log out'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          onChanged: (value) {},
          dropdownStyleData: DropdownStyleData(
            width: 214.w,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.whiteBlackColor(context),
            ),
            elevation: 8,
            offset: const Offset(-5, 8),
          ),
          menuItemStyleData: MenuItemStyleData(
            customHeights: [
              ...List<double>.filled(6, 48),
            ],
            padding: const EdgeInsets.only(left: 16, right: 16),
          ),
          customButton: SvgPicture.asset(
            'assets/icons/menu.svg',
            width: 22.4,
            height: 19.2,
          ),
          items: [
            DropdownMenuItem<Divider>(
              enabled: false,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.borderWhiteColor(context)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    filled: true,
                    fillColor:
                        AppColors.lighterGreyColor(context).withOpacity(.4),
                    suffixIcon: Icon(Icons.search,
                        color: AppColors.blueColor(context))),
              ),
            ),
            ...dropdownItems.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )),
            DropdownMenuItem(
                value: themeProvider.isDarkMode,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () => themeProvider.toggleTheme(),
                  title: const Text("Dark Mode"),
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (_) {
                      themeProvider.toggleTheme();
                    },
                  ),
                )),
          ],
        ),
      );
    });
  }
}
