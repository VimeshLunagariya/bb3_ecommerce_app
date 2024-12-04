import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetSideViewWidget extends StatefulWidget {
  final String title;
  final bool isTabSelect;
  final VoidCallback onTap;
  const FilterBottomSheetSideViewWidget({super.key, required this.title, required this.isTabSelect, required this.onTap});

  @override
  State<FilterBottomSheetSideViewWidget> createState() => _FilterBottomSheetSideViewWidgetState();
}

class _FilterBottomSheetSideViewWidgetState extends State<FilterBottomSheetSideViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: widget.isTabSelect ? Colors.white : Colors.black.withOpacity(0.1),
        width: VariableUtilities.screenSize.width * 0.30,
        height: VariableUtilities.screenSize.height * 0.06,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: widget.isTabSelect
                    ? FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)
                    : FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.regular),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
