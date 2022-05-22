import 'package:flutter/material.dart';
import '../contants/bmi.dart';

BoxDecoration neumorphism (
  double radius, 
  double offset, 
  double blur, 
  double spread
  ) => BoxDecoration(
  borderRadius: BorderRadius.circular(radius),
  color: CustomColor.brightGrey ,
  boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey,
        offset:  Offset(offset, offset),
        blurRadius: blur,
        spreadRadius: spread,
      ),
      BoxShadow(
        color: Colors.white,
        offset:  Offset(-offset, -offset),
        blurRadius: blur,
        spreadRadius: spread,
      )
  ]
);

BoxDecoration genderNeumorphism (bool condition) => BoxDecoration(
  borderRadius: BorderRadius.circular(18.0),
  gradient:  LinearGradient(
    begin: Alignment.centerLeft,
    stops: condition ? [0.0, 0.8] : [0.0],
    end: Alignment.centerRight,
    colors: condition ? <Color>[CustomColor.seaSerpent, CustomColor.seaSerpent2] : [CustomColor.brightGrey]
  ),
  boxShadow: const <BoxShadow>[
    BoxShadow(
      color: Colors.grey,
      offset:  Offset(4, 4),
      blurRadius: 4,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Colors.white,
      offset:  Offset(-4, -4),
      blurRadius: 4,
      spreadRadius: 1,
    )
  ]
);