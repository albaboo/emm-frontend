import 'package:flutter/material.dart';



class ListConfig extends StatelessWidget {



final icon ;
final String listName;
final String  subName;
final color ; 


  const ListConfig({
    Key? key ,
    required this.icon,
    required this.listName,
    required this.subName,
    required this.color,
    
    
    
    
    }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                      
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: Container(
                          padding: EdgeInsets.all(16),
                          color:color ,
                          child: Icon(
                            icon,
                          ),
                        ),
                        ),
                       
                         SizedBox(
                         width : 5
                         ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                         width : 5
                         ),
                         //subtarea:
                         Text(
                              subName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                         )
                      ],
                    ) ,
                    Icon(Icons.more_horiz),
                      ],
                    )
                  ),
    );
  }
}