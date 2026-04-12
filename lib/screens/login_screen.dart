import 'package:emm_app/components/my_button.dart';
import 'package:emm_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import '../components/my_textfield.dart';
import '../widgets/logoEmm_widget.dart';


class LoginScreen extends StatelessWidget {
    LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  
  @override
 Widget build(BuildContext context){
  return Scaffold(

    backgroundColor: const Color(0xFFF7F3FA),
   body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // LOGO 
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: logoWidget(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'EMM_Login',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D2A3A),
                    ),
                  ),

          const   SizedBox(height: 50),

             const Text(
                    'Inicia sesión para continuar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A5568),
                    ),
                  ),

             const     SizedBox(height: 50),

               //USERNAME:
                MyTextfield(
                  controller:usernameController,
                  hintText: 'Username',
                  obscureText: false,


                ),

            const    SizedBox(height: 20),

                //password:
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

             const    SizedBox(height: 30),

             //button:

             MyButton(),
              const SizedBox(height: 20),
        ],
      ),
      ),
      ),
      ),
      ),
  );
 }
  
}