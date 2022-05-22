import 'package:flutter/material.dart';
import 'dart:math';


class CustomColor {
  static const Color normal = Color(0xFF3AB54A);
  static const Color overweight = Color(0xFFFFEF01);
  static const Color obese = Color(0xFFEF6422);

  static const Color seaSerpent = Color(0xFF56D0DB);
  static const Color seaSerpent2 = Color(0xFF59C8E3);
  static const Color brightGrey = Color(0xFFEDEDED);
  static const Color rhythm = Color(0xFF767C94);
  static const Color text = Color(0xFFFCFFFE);

  static const Color raspberry = Color(0xFFFE0167);
  static const Color cetacean  = Color(0xFF0C1234);
  static const Color yankees = Color(0xFF13193B);
  static const Color unselected = Color(0xFFB7B9C8);
  static const Color selected = Color(0xFFFEFDFF);
  // static const Color text = Color(0xFFFCFFFE);

  static Color getBmiColor (double bmiNumber){
    if(bmiNumber >= 2.75) { return CustomColor.overweight;}
    else if(bmiNumber >= 23.0) {return CustomColor.obese;}
    else if(bmiNumber >= 23.0) {return CustomColor.normal;}
    else {return CustomColor.selected;}
  }
}

String onCategorizedBMI(double bmiResult) {
  if (bmiResult >= 40.0) {return 'Obese (Class III)';}
  else if(bmiResult >= 35.0) {return 'Obese (Class II)';}
  else if(bmiResult >= 30.0) {return 'Obese (Class I)';}
  else if(bmiResult >= 25.0) {return 'Overweight (Pre-Obese)';}
  else if(bmiResult >= 18.5) {return 'Normal';}
  else if(bmiResult >= 17.0) {return 'Underweight (Mild Thinness)';}
  else if(bmiResult >= 16.0) {return 'Underweight (Moderate Thinness)';}
  else {return 'Underweight (Severe Thinness)';}
}

String onCategorizeHealthRisk(double bmiResult) {
  if(bmiResult >= 27.5) {
    return 'High risk of developing, heart disease, high blood pleasure, stroke, diabetes mellitus. Metabolic Syndrom ';
  }
  else if(bmiResult >= 23.0) {
    return 'Moderate risk of developing, heart disease, high blood pleasure, stroke, diabetes mellitus.';
  }
  else if( bmiResult >= 18.5) {
    return 'Low Risk (healthy range)';
  }
  else {
    return 'Possible nutritional deficiency and osteoprosis';
  }
}

Color onCategorizeHealthRiskColor(double bmiResult){
  if(bmiResult >= 27.5) { return CustomColor.overweight;}
  else if(bmiResult >= 23.0) {return CustomColor.obese;}
  else if( bmiResult >= 18.5) {return CustomColor.normal;}
  else {return CustomColor.selected;}
}

const double twoPI = 3.14 * 2;
const double gaugeSize = 240;

class Person {
  String _gender = 'male';
  int _height = 160;
  int _weight = 64;
  int _age = 27;

  String get gender => _gender;
  set gender(chooseGender) => _gender = chooseGender;

  int get height => _height;
  set height(heightValue) => _height = heightValue;

  int get weight => _weight;
  int get age => _age;

  setWeight(bool increase) => increase ?
      _weight < 200 ? _weight++ : _weight :
        _weight > 40 ? _weight-- : _weight;
  setAge(bool increase) => increase ?
      _age < 90 ? _age++ : _age :
        _age > 18 ? _age-- : _age;

}

class BMIResult {
  double? bmiNumber;
  String? category;
  String? risk;
  Color? color;

  BMIResult({this.bmiNumber, this.category, this.risk, this.color,});

  static double calculateBMI(int height, int weight) {
    double bmiResult = (weight / pow((height/100), 2));
    String roundDouble = bmiResult.toStringAsExponential(2);
    return double.parse(roundDouble);
  }

  static BMIResult getBmiResult(Person person)  {
    double bmiResult = calculateBMI(person.height, person.weight);
    return BMIResult(
      bmiNumber: bmiResult,
      category: onCategorizedBMI(bmiResult),
      risk: onCategorizeHealthRisk(bmiResult),
      color: onCategorizeHealthRiskColor(bmiResult)
    );
  }
}