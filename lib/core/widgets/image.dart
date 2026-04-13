import 'package:flutter/material.dart';

Widget ImageWidget({String path = 'assets/image/family.png', double width = 100}) {
  return Image.asset(path, width: 100);
}