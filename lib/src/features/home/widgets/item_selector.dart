// ignore_for_file: library_private_types_in_public_api

import 'package:binance_sly/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class ItemSelector extends StatefulWidget {
  const ItemSelector({super.key});

  @override
  _ItemSelectorState createState() => _ItemSelectorState();
}

class _ItemSelectorState extends State<ItemSelector> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(0, 'Limit'),
          _buildItem(1, 'Market'),
          _buildItem(2, 'Stop-Limit'),
        ],
      ),
    );
  }

  Widget _buildItem(int index, String title) {
    bool isSelected = index == selectedItemIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItemIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected
              ? AppColors.darkGreyColor(context)
              : Colors.transparent,
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: AppStyles.black14Medium.copyWith(
              color: isSelected
                  ? AppColors.blackWhiteColor(context)
                  : AppColors.secondaryColor(context)),
        ),
      ),
    );
  }
}
