import 'package:flutter/material.dart';
import 'package:flutter_application_4/views/login_view.dart';
import 'package:flutter_application_4/views/signup_view.dart';

class FirstSplashView extends StatelessWidget {
  final String? text;

  const FirstSplashView({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double circleSize = (screenWidth * 0.2).clamp(40.0, 80.0);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 1),
          CircularImg(circleSize: circleSize),

          SizedBox(height: 20),

          Text(
            'متابعة مستمرة',
            style: TextStyle(
              fontFamily: 'almarai',

              color: const Color.fromARGB(255, 252, 0, 0),
              fontSize: 30,
            ),
          ),

          SizedBox(height: 50),

          Text(
            'سجل دخولك للمتابعة',
            style: TextStyle(fontFamily: 'almarai', fontSize: 16),
          ),
          Spacer(flex: 2),
          Container(
            alignment: Alignment.bottomLeft,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 27),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0F67FF),
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignupView()),
                );
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  " التالي",
                  style: TextStyle(
                    fontFamily: "almarai",
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class CircularImg extends StatelessWidget {
  const CircularImg({super.key, required this.circleSize});

  final double circleSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: circleSize,
      backgroundColor: Color.fromARGB(83, 91, 102, 205),
      child: Center(
        child: Icon(
          Icons.health_and_safety_outlined,
          size: circleSize + 20,
          color: const Color.fromARGB(255, 75, 20, 255),
        ),
      ),
    );
  }
}
