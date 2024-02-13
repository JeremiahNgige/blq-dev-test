import 'package:blq_developer_test/utils/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/sizes.dart';
import 'custom_textfiled_viewmodel.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextEditingController controller;
  final String? validationMessage;
  final TextInputType inputType;
  final String? errorTextId;
  final Widget? prefix;
  final bool? enabled;

  const CustomTextField(
      {super.key,
      this.prefix,
      this.enabled,
      required this.controller,
      required this.errorTextId,
      required this.hint,
      required this.validationMessage,
      required this.inputType,
      required this.label});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<CustomTextFieldViewModel>.reactive(
      viewModelBuilder: () => CustomTextFieldViewModel(),
      builder: (context, model, child) => Container(
        height: 60,
        padding: Spacing.all(7),
        width: MediaQuery.of(context).size.width * 0.80,
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(
                color: ColorResources.shimmerLightColor!.withOpacity(0.4),
                width: 0.5)),
        child: TextFormField(
          enabled: enabled ?? true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style:
              theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: InputBorder.none,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.colorScheme.error),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: InputBorder.none,
            focusColor: Colors.pink,
            isDense: true,
            filled: true,
            suffixIcon: Card(
              color: ColorResources.primaryColor.withAlpha(250),
              elevation: 2,
              margin: Spacing.all(1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.arrow_upward,
                color: theme.primaryColorDark,
                size: 13,
              ),
            ),
            fillColor: theme.cardColor,
            hintStyle: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground),
            contentPadding: Spacing.all(5),
          ),
          validator: (value) {
            return model.validate(value, errorTextId);
          },
          controller: controller,
          autofocus: true,
        ),
      ),
    );
  }
}
