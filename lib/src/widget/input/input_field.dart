// ignore_for_file: lines_longer_than_80_chars

import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Validator for text field
typedef Validator = String? Function(String?)?;
typedef OnChangedCallback = void Function(String? value);

///Input text field
class InputFieldWidget extends StatelessWidget {
  ///Input text field constructor

  const InputFieldWidget({
    required this.controller,
    this.lable,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.hintText,
    this.readOnly,
    this.onChange,
    this.isObscure = false,
    this.alternativeWidgetForTextfield,
    this.textInputType = TextInputType.name,
    this.inputFormatters = const [],
    super.key,
  });
  final TextEditingController controller;
  final String? lable;

  final String? hintText;
  final Validator validator;
  final OnChangedCallback? onChange;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isObscure;
  final Widget? alternativeWidgetForTextfield;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable == '' ? const SizedBox() : Text(lable!, style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.bold)),
        lable == '' ? const SizedBox() : const SizedBox(height: 8),
        alternativeWidgetForTextfield ??
            TextFormField(
              onTap: onTap ?? () {},
              validator: validator ??
                  (String? value) {
                    return null;
                  },
              inputFormatters: inputFormatters ?? [],
              onChanged: onChange ?? (String value) {},
              controller: controller,
              readOnly: readOnly ?? false,
              obscureText: isObscure!,
              keyboardType: textInputType ?? TextInputType.number,
              cursorColor: VariableUtilities.theme.color444444,
              style: FontUtilities.h12(fontColor: VariableUtilities.theme.blackColor, fontWeight: FWT.semiBold),
              decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText,
                  errorStyle: FontUtilities.h10(fontColor: VariableUtilities.theme.colorE94444, fontWeight: FWT.medium),
                  hintStyle: FontUtilities.h10(fontColor: VariableUtilities.theme.color7C7C7C, fontWeight: FWT.medium),
                  labelStyle: FontUtilities.h16(fontColor: VariableUtilities.theme.color7C7C7C),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: VariableUtilities.theme.color7C7C7C, style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: VariableUtilities.theme.color7C7C7C, style: BorderStyle.solid)),
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  hoverColor: VariableUtilities.theme.color444444),
            ),
      ],
    );
  }
}
