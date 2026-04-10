
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget logoWidget() {
  if (kIsWeb) {
    // Si es web, usa este logo
    return Image.asset('lib/assets/icon.png', width: 100);
  } else {
   
      return Image.asset('lib/assets/icon.png', width: 100);
   
  }
}