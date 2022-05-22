import 'package:flutter/material.dart';
import 'package:tugas_tiga/contants/bmi.dart';
import 'package:tugas_tiga/widgets/neumorphism.dart';

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
                  decoration: neumorphism(42, 4, 8, 1),
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
              decoration: neumorphism(42, 4, 6, 1),
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
                        decoration: neumorphism(gaugeSize, 4, 18, 1),
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