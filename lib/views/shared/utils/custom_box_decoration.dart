// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CustomBoxDecoration {
  static BoxDecoration dealsListTileDecoration = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(4),
      boxShadow: const [
        BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            blurStyle: BlurStyle.normal,
            offset: Offset(0, 2),
            spreadRadius: 2)
      ]);
}
