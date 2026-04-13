import 'package:flutter/material.dart';



class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF7CB3FF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
      child:const  Center(
        child: Text(
          "inscribirse",
          style: TextStyle(
            color : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            ),
            ),
          
          ),
          );
   
   
  }
}