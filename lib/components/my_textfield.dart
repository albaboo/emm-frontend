import 'package:flutter/material.dart';



class MyTextfield extends StatelessWidget {

  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
       decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}