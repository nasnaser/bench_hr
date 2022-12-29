import 'package:flutter/material.dart';

class MyPageTransition extends PageRouteBuilder{
 final page;
 MyPageTransition({required this.page}):super(pageBuilder: (context, animation,
     animationtow)=>page,transitionsBuilder: (context,animation,animationtow,child){
  var begin=Offset(1.0,0.0);
  var end=Offset.zero;
  var tween=Tween(begin: begin,end: end);
  var offsetAnimation=animation.drive(tween);
  return SlideTransition(position: offsetAnimation,child: child);
 });

}