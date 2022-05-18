import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

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

// double onCalculateBMI(int height, int weight) {
//   double bmiResult = (weight / pow((height/100), 2));
//   String roundDouble = bmiResult.toStringAsExponential(2);
//   return double.parse(roundDouble);
// }

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
  String gender = 'male';
  int height = 160;
  int weight = 64;
  int age = 27;


  setGender(String chooseGender) => chooseGender == 'female' ? gender = 'female' : gender = 'male';
  setHeight(double value) => height = value.round();
  setWeight(bool increase) => increase ?
      weight < 200 ? weight++ : weight :
        weight > 40 ? weight-- : weight;
  setAge(bool increase) => increase ?
      age < 90 ? age++ : age :
        age > 18 ? age-- : age;

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


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'BMI Calculator'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double buttonHeight = 20.00;

  Person person = Person();

  BMIResult bmiResult = BMIResult();



  void _onSettingState(Function function) => {
    setState(() {
      function();
    },)
  };

  void _goToSecondPage ()  {
    bmiResult = BMIResult.getBmiResult(person);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          bmiResult: bmiResult
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: CustomColor.brightGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(42),
                  color: CustomColor.brightGrey ,
                  boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset:  Offset(4, 4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset:  Offset(-4, -4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                  ]
                ),
                child: const Center(
                  child: Icon(
                    Icons.apps, color: CustomColor.rhythm
                  )
                )
              )
            ),
            Expanded(
              child: Center (
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    inherit: false,
                    color: CustomColor.rhythm,
                    fontSize: 20
                  )
                )
              )
            ),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: CustomColor.brightGrey ,
                boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset:  Offset(4, 4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset:  Offset(-4, -4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    )
                ]
              ),
              child: const Center(
                child: Icon(
                  Icons.person_outline, color: CustomColor.rhythm
                )
              )
            )
          )
          ],
        ),
      ),
      body: Container(
        color:CustomColor.brightGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Column(
                children: [
                  SizedBox(
                    height: 80.00,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //MALE
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () => _onSettingState(() => person.setGender('male')),
                              child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                gradient:  LinearGradient(
                                  begin: Alignment.centerLeft,
                                  stops: person.gender == 'male'? [0.0, 0.8] : [0.0],
                                  end: Alignment.centerRight,
                                  colors: person.gender =='male' ? <Color>[CustomColor.seaSerpent, CustomColor.seaSerpent2] : [CustomColor.brightGrey]
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
                              ),
                              child: Center(
                                child: Text(
                                  "Male",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: person.gender == 'male' ? CustomColor.text : CustomColor.rhythm
                                  )
                                )
                              )
                            )
                            )
                          )
                        ),
                        //FEMALE
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => _onSettingState(() => person.setGender('female')),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  gradient:  LinearGradient(
                                    begin: Alignment.centerLeft,
                                    stops: person.gender == 'female'? [0.0, 0.8] : [0.0],
                                    end: Alignment.centerRight,
                                    colors: person.gender == 'female' ? <Color>[CustomColor.seaSerpent, CustomColor.seaSerpent2] : [CustomColor.brightGrey]
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
                                ),
                                child: Center(
                                  child: Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize:18,
                                      color: person.gender == 'female' ? CustomColor.text : CustomColor.rhythm
                                    )
                                  )
                                )
                              ) ,
                            )
                          )
                        ),
                      ],
                    )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 28.0),
                        child: Row(
                        children: <Expanded>[
                          // HEIGHT
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: CustomColor.brightGrey ,
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
                                  ),
                                child: Column (
                                  children:  [
                                     const SizedBox(
                                      height: 48,
                                      child: Center(
                                        child: Text(
                                          'Height',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: CustomColor.rhythm
                                          )
                                        )
                                      )
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: Slider(
                                                  value: person.height.toDouble(),
                                                  thumbColor: Colors.white,
                                                  activeColor: CustomColor.seaSerpent2,
                                                  inactiveColor: CustomColor.unselected,
                                                  min: 130.0,
                                                  max: 230.0,
                                                  onChanged: (double newValue) => _onSettingState(() => person.setHeight(newValue)),
                                                )
                                            )
                                          ),
                                          Expanded(
                                            child:
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${person.height}',
                                                  style: const TextStyle(
                                                    fontSize: 36,
                                                    color: CustomColor.rhythm
                                                  )
                                                )
                                              )
                                          )
                                        ],
                                      )
                                    )
                                  ],
                                )
                                )
                            )
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    // WEIGHT
                                    Expanded(
                                      flex:6,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          color: CustomColor.brightGrey ,
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
                                        ),
                                         child: Column(
                                           children: [
                                            const SizedBox(
                                                height: 48,
                                                child: Center(
                                                  child: Text(
                                                    'Weight',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: CustomColor.rhythm
                                                    )
                                                  )
                                                )
                                              ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${person.weight}',
                                                  style: const TextStyle(
                                                    fontSize: 48,
                                                    color: CustomColor.rhythm
                                                  )
                                                )
                                              )
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 8.0),
                                              height: 64,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => _onSettingState(() => person.setWeight(false)),
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(42),
                                                        color: CustomColor.brightGrey ,
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
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.remove, color: CustomColor.rhythm
                                                        )
                                                      )
                                                    )
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => _onSettingState(() => person.setWeight(true)),

                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(42),
                                                        color: CustomColor.brightGrey ,
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
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add, color: CustomColor.rhythm
                                                        )
                                                      )
                                                    )
                                                  )
                                                ]
                                              )
                                            )
                                           ]
                                         )
                                      )
                                    ),
                                    const Spacer( flex:1),
                                    // AGE
                                    Expanded(
                                      flex:6,
                                       child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18.0),
                                            color: CustomColor.brightGrey ,
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
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                                height: 48,
                                                child: Center(
                                                  child: Text(
                                                    'Age',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: CustomColor.rhythm
                                                    )
                                                  )
                                                )
                                              ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${person.age}',
                                                  style: const TextStyle(
                                                    fontSize: 48,
                                                    color: CustomColor.rhythm
                                                  )
                                                )
                                              )
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 8.0),
                                              height: 64,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => _onSettingState(() => person.setAge(false)),
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(42),
                                                        color: CustomColor.brightGrey ,
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
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.remove, color: CustomColor.rhythm
                                                        )
                                                      )
                                                    )
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => _onSettingState(() => person.setAge(true)),
                                                    child: Container(
                                                    height: 42,
                                                    width: 42,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(42),
                                                      color: CustomColor.brightGrey ,
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
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.add, color: CustomColor.rhythm
                                                      )
                                                    )
                                                  ))
                                                ]
                                              )
                                            )
                                          ]
                                        )
                                      )
                                     )
                                  ],
                                )
                              )
                            ),
                          ],
                        )
                      )
                    )
                  ],
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0, right:8.0, bottom:60.0),
              child:  Container(
                alignment: Alignment.center,
                height: 70.00,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => _goToSecondPage(),
                  child: Card(
                    color: CustomColor.seaSerpent,
                    elevation: 12.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        'Let\'s Begin',
                        style: TextStyle(
                          color: CustomColor.text,
                          fontSize: 18
                        )
                      ),
                    )
                  )
                )
              )
            )
          ],
        ),
        )
      )
    );
  }
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.bmiResult}): super(key:key);

  final BMIResult bmiResult;

  @override
  State<ResultScreen> createState() =>_ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {



 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: CustomColor.brightGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    color: CustomColor.brightGrey ,
                    boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset:  Offset(4, 4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset:  Offset(-4, -4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                    ]
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left, color: CustomColor.rhythm
                    )
                  )
                )
              )
            ),
            const Expanded(
              child: Center (
                child: Text(
                  'BMI Results',
                  style: TextStyle(
                    inherit: false,
                    color: CustomColor.rhythm,
                    fontSize: 20
                  )
                )
              )
            ),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: CustomColor.brightGrey ,
                boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset:  Offset(4, 4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset:  Offset(-4, -4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    )
                ]
              ),
              child: const Center(
                child: Icon(
                  Icons.person_outline, color: CustomColor.rhythm
                )
              )
            )
          )
            // Your widgets here
          ],
        ),
      ),
      body: Container(
        color:CustomColor.brightGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: gaugeSize,
                        width: gaugeSize,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(gaugeSize),
                          color: CustomColor.brightGrey,
                          boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset:  Offset(4, 4),
                                blurRadius: 18,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset:  Offset(-4, -4),
                                blurRadius: 18,
                                spreadRadius: 1,
                              )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                            child: TweenAnimationBuilder(
                              tween: Tween( begin: 0.0, end: (1.0 * (widget.bmiResult.bmiNumber! / 29.9)) ),
                              duration: const Duration(seconds: 1),
                              builder: (context, double value, child) {

                                return SizedBox(
                                  child: Stack(
                                    children:[
                                      ShaderMask(
                                        shaderCallback: (rect){
                                          return  SweepGradient(
                                            startAngle: 0.0,
                                            endAngle: twoPI,
                                            stops: [value, value],
                                            center: Alignment.center,
                                            colors: [const Color.fromARGB(255, 66, 238, 253), Colors.grey.withAlpha(25)]
                                          ).createShader(rect);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: CustomColor.seaSerpent2
                                          ),
                                        )
                                      ),
                                      Center(
                                        child: Padding (
                                          padding: const EdgeInsets.all(18.0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: CustomColor.brightGrey,
                                              shape: BoxShape.circle
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${widget.bmiResult.bmiNumber}',
                                                style: const TextStyle(
                                                  fontSize: 48,
                                                  color: CustomColor.rhythm
                                                )
                                              )
                                            )
                                          )
                                        )
                                      )
                                    ],
                                  )
                                );
                              }
                            )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:36.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child : RichText(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            text: TextSpan (
                              style: const TextStyle(
                                color:CustomColor.rhythm,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'You have ',
                                ),
                                TextSpan(
                                  text:'${widget.bmiResult.category?.split(' ')[0]}',
                                  style: const TextStyle(
                                    color:CustomColor.seaSerpent,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                const TextSpan(
                                  text: ' body weight !',
                                )
                              ],
                            )
                          )
                        )
                      )
                    ]
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0, right:8.0, bottom:60.0),
                child:  Container(
                  alignment: Alignment.center,
                  height: 70.00,
                  width: 180.00,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Card(
                      color: CustomColor.brightGrey,
                      elevation: 12.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Text(
                          'Let\'s Begin',
                          style: TextStyle(
                            color: CustomColor.rhythm,
                            fontSize: 18
                          )
                        ),
                      )
                    )
                  )
                )
              )
            ],
          )
        )
      )
    );
  }
}
