import 'package:flutter/material.dart';
import 'package:tugas_tiga/views/result_screen.dart';
import 'package:tugas_tiga/widgets/neumorphism.dart';
import '../contants/bmi.dart';

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
                decoration: neumorphism(42, 4, 8, 1),
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
              decoration: neumorphism(42, 4, 6, 1),
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
                              onTap: () => _onSettingState(() => person.gender = 'male'),
                              child: Container(
                              decoration: genderNeumorphism(person.gender == 'male'),
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
                            onTap: () => _onSettingState(() => person.gender = 'female'),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: genderNeumorphism(person.gender == 'female'),
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
                                  decoration: neumorphism(18.0, 4, 4, 1),
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
                                                    onChanged: (double newValue) => _onSettingState(() => person.height = newValue.round()),
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
                                      flex: 6,
                                      child: Container(
                                        decoration: neumorphism(18.0, 4, 4, 1),
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
                                                      decoration: neumorphism(42, 4, 4, 1),
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
                                                      decoration:neumorphism(42, 4, 4, 1),
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
                                        decoration: neumorphism(18, 4, 4, 1),
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
                                                      decoration: neumorphism(42, 4, 4, 1),
                                                      
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
                                                      decoration: neumorphism(42, 4, 4, 1),
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

