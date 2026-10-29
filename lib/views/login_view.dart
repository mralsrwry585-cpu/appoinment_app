import 'package:flutter/material.dart';
//import 'package:flutter_application_4/models/patient.dart';
import 'package:flutter_application_4/services/auth_service.dart';
import 'package:flutter_application_4/views/buttom.dart';
//import 'package:flutter_application_4/views/main_view.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_application_4/widgets/account_type_widget.dart';
import 'package:flutter_application_4/widgets/button_with_loading.dart';
import 'package:flutter_application_4/widgets/input_field_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passController = TextEditingController();

  String selectedType = "patient"; 

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double circleSize = screenWidth * 0.1 + 15;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),

              CircularImg(circleSize: circleSize),

              SizedBox(height: 20),

              Text(
                'مرحباً بك',
                style: TextStyle(
                  fontFamily: 'almarai',
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'سجل دخولك للمتابعة',
                style: TextStyle(fontFamily: 'almarai', fontSize: 16),
              ),

              SizedBox(height: 30),

        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTypeWidget(
                    isLeftButton: false,
                    name: 'مريض',
                    isSelected: selectedType == "patient",
                    onTap: () {
                      print("Tapped مريض"); 
                      setState(() {
                        selectedType = "patient";
                      });
                      print("selectedType = $selectedType");
                    },
                  ),
                  SizedBox(width: 10),
                  AccountTypeWidget(
                    isLeftButton: true,
                    name: 'دكتور',
                    isSelected: selectedType == "doctor",
                    onTap: () {
                      print("Tapped دكتور"); 
                      setState(() {
                        selectedType = "doctor";
                      });
                      print("selectedType = $selectedType");
                    },
                  ),
                ],
              ),

              SizedBox(height: 40),

             
              InputField(
                labelText: 'رقم الهاتف',
                hintText: '771641806',
                controller: phoneController,
                isSecure: false,
                isNumberOnly: true,
                icon: Icon(
                  Icons.phone_android,
                  color: Color(0xFF0F67FF),
                  size: 23,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال رقم الهاتف";
                  }
                  if (value.length < 9) {
                    return "رقم الهاتف غير صحيح";
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),

              InputField(
                labelText: 'كلمة المرور',
                hintText: '••••••••',
                controller: passController,
                isSecure: true,
                isNumberOnly: false,
                icon: Icon(Icons.lock, color: Color(0xFF0F67FF), size: 23),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال كلمة المرور";
                  }
                  if (value.length < 3) {
                    return "كلمة المرور قصيرة جداً";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10),

              Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 27),
                child: TextButton(
                  child: Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyle(
                      fontFamily: 'almarai',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF0F67FF),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 27),
                child: // داخل صفحة LoginScreen في دالة build
                LoginButton(
                  text: 'تسجيل الدخول',
                  onLogin: () async {
                    final patient = await AuthService().login(
                      phoneController.text,
                      passController.text,
                      selectedType,
                    );

                    if (!mounted) return;

                   
                   
                    if (patient != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => BottomNavBar(patient: patient),
                        ),
                      );
                    } else {
                      showErrorDialog(
                        context,
                        'رقم الهاتف أو كلمة المرور خاطئة',
                      );
                      passController.clear();
                    }
                  },
                ),
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ليس لديك حساب؟ ',
                    style: TextStyle(fontFamily: 'almarai', fontSize: 17),
                  ),
                  GestureDetector(
                    child: Text(
                      ' سجل الآن   ',
                      style: TextStyle(
                        fontFamily: 'almarai',
                        fontSize: 17,
                        color: Color(0xFF0F67FF),
                      ),
                    ),
                    onTap: () {
                      print('go to Sign up page');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
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

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 50, color: Colors.red),
              SizedBox(height: 15),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'almarai',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'حسناً',
                  style: TextStyle(fontFamily: 'almarai', fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

