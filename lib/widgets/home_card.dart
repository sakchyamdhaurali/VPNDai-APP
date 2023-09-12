import 'package:flutter/material.dart';

import '../main.dart';

class HomeCard extends StatelessWidget {
  final String title,subtiltle;
  final Widget icon;
const HomeCard({ Key? key, required this.title, required this.subtiltle, required this.icon }) : super(key: key);

  @override
  Widget build(BuildContext context){

    return SizedBox(
      width: mq.width* .45,
      child: Column(
        children: [
          icon ,
          SizedBox(height: 6,),
          Text(title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          ),
          SizedBox(height: 6,),

          Text(subtiltle,
           style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ), 
        ],
      ),
    );
  }
}