
import 'package:flutter/material.dart';
import 'task_widgets.dart';



class FormScreen extends StatefulWidget  {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // Panel profesional 
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        size: 40,
                        color: Color.fromARGB(255, 221, 50, 82),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Panel Profesional',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  
                  Row(
                    children: [

                      // Dar alta usuario
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                      ),

                      // Consultas 
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 134, 81, 180),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        margin: EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Consultas',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      // out
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 30, 28, 32),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.output,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // config

             Align(
                alignment: Alignment.centerLeft,
                child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 67, 58, 154),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        margin: EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Configuración',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
             ),


                ///List:
                //1:search bar : 
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                       SizedBox(
                       width : 5
                       ),
                       Text(
                        'Buscar...',
                        style: TextStyle(
                          color:Colors.white,
                        ),
                       )

                    ],
                  ),
                ),
                
                //minilist:
                Expanded(
                    child: ListView(
                      children: [

                        sectionTile(
                          icon: Icons.checklist_rtl,
                          color: Colors.lightGreen,
                          title: "Tipo de Tareas",
                          subtitle: "2 tareas pendientes",
                          items: ["Tarea 1", "Tarea 2"],
                        ),

                        sectionTile(
                          icon: Icons.auto_awesome_mosaic,
                          color: const Color.fromARGB(255, 146, 146, 199),
                          title: "Grupo de Tareas",
                          subtitle: "Lista de grupos",
                          items: ["Tarea 1", "Tarea 2", "Tarea 3"],
                        ),

                        sectionTile(
                          icon: Icons.contact_support,
                          color: Colors.amber,
                          title: "Guía de Ayuda",
                          subtitle: "Pasos de ayuda",
                          items: ["Paso 1", "Paso 2", "Paso 3"],
                        ),

                      ],
                    ),
                  )

             
            ],
          ),
        ),
      ),
    );
  }
}