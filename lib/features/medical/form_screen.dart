
import 'package:emm_app/core/utils/list_config.dart';
import 'package:flutter/material.dart';



class FormScreen extends StatefulWidget  {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  bool showTasks = false;

  List<String> tasks = ["Tarea 1", "Tarea 2"];



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
                Expanded(child: ListView(
                    children: [
                      
                       ListConfig(
                        icon:  Icons.checklist_rtl,  
                        color: Colors.lightGreen,
                        listName: 'Tipo de Tareas',
                        subName: ' 2 Tareas pendientes',
                      ),
                 
                      ListConfig(
                        icon:  Icons.auto_awesome_mosaic,  
                        listName: 'Grupo de Tareas',
                        color : const Color.fromARGB(255, 146, 146, 199),
                        subName: 'grupo de tareas',
                      ),
                      ListConfig(
                         icon:  Icons.contact_support,  
                        listName: 'Guia de Ayuda',
                        color: Colors.amber,
                        subName: 'help guide',
                      ),

                    ],
                ))

             
            ],
          ),
        ),
      ),
    );
  }
}