import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';

///SearchInputField
class SearchInputField extends StatelessWidget {
  ///SearchInputField Constructor
  const SearchInputField({required this.searchController, this.suffixIcon, this.autoFocus = true, this.onChanged, super.key, this.hintText = 'Search', this.fillColor, this.isDense = false});

  ///Search Controller
  final TextEditingController searchController;

  ///On Changed
  final Function(String)? onChanged;

  //AutoFoucs
  final bool autoFocus;

  //IsDense
  final bool isDense;

  ///Suffix icon
  final Widget? suffixIcon;

  ///Hint Text
  final String hintText;

  ///Fill Color
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: fillColor ?? VariableUtilities.theme.whiteColor,
        border: fillColor != null ? Border.all(color: Colors.grey.withOpacity(0.4)) : null,
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: VariableUtilities.theme.color7C7C7C),
            const SizedBox(width: 10),
            Expanded(
              child: Center(
                child: TextField(
                  autofocus: autoFocus,
                  controller: searchController,
                  onChanged: onChanged,
                  cursorColor: VariableUtilities.theme.color7C7C7C,
                  style: FontUtilities.h10(fontColor: VariableUtilities.theme.color7C7C7C, fontWeight: FWT.semiBold),
                  decoration: InputDecoration(
                    isDense: isDense,
                    hintText: hintText,
                    hintStyle: FontUtilities.h10(fontColor: VariableUtilities.theme.color7C7C7C, fontWeight: FWT.medium),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            suffixIcon ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
