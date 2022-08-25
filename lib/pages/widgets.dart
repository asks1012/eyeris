import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';

Widget homeMaterialButton(
    void Function() onPressed, String buttonText, double width) {
  return MaterialButton(
    elevation: 5,
    splashColor: Palette.myTheme,
    onPressed: onPressed,
    minWidth: width,
    color: Palette.myTheme,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            buttonText,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
          ),
          const Text(
            "➝",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}
