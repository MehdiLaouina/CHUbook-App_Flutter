// ignore: file_names
// ignore_for_file: void_checks, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SearchBarUtils {
  static Widget searchBar(
      BuildContext context,
      String keyName,
      String placeHolder,
      String addButtonLabel,
      Function onSearchTap,
      Function onAddButtonTab) {
    String val = "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FormHelper.inputFieldWidget(
            context,
            keyName,
            placeHolder,
            showPrefixIcon: false,
            () {},
            () {},
            onChange: (onChangeVal) => {val = onChangeVal},
            suffixIcon: SizedBox(
              child: GestureDetector(
                onTap: () {
                  return onSearchTap(val);
                },
                child: const Icon(Icons.search),
              ),
            ),
            borderFocusColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            paddingLeft: 0,
          ),
        ),
        Expanded(
          child: FormHelper.submitButton(addButtonLabel, () {
            return onAddButtonTab();
          },
              borderRadius: 10,
              width: 100,
              fontSize: 12,
              btnColor: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}
