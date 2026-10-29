import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/views/login_view.dart';
import 'package:flutter_application_4/widgets/account_type_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final rePassController = TextEditingController();

  String selectedType = "مريض"; // ← نوع الحساب المختار

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

              // اختيار نوع الحساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTypeWidget(
                    isLeftButton: false,
                    name: 'مريض',
                    isSelected: selectedType == "مريض",
                    onTap: () {
                      print("Tapped مريض"); // للتصحيح
                      setState(() {
                        selectedType = "مريض";
                      });
                      print("selectedType = $selectedType");
                    },
                  ),
                  SizedBox(width: 10),
                  AccountTypeWidget(
                    isLeftButton: true,
                    name: 'دكتور',
                    isSelected: selectedType == "دكتور",
                    onTap: () {
                      print("Tapped دكتور"); // للتصحيح
                      setState(() {
                        selectedType = "دكتور";
                      });
                      print("selectedType = $selectedType");
                    },
                  ),
                ],
              ),

              SizedBox(height: 40),
              InputField(
                labelText: ' الاسم الكامل',
                hintText: 'عمر مختار حسين السروري',
                controller: nameController,
                isSecure: false,
                isNumberOnly: false,
                icon: Icon(Icons.person, color: Color(0xFF0F67FF), size: 23),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال  اسمك  كاملا";
                  }
                  if (value.length < 9) {
                    return " الاسم غير صحيح";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // 🔵 رقم الهاتف
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

              SizedBox(height: 20),

              // 🔵 كلمة المرور
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
                  if (value.length < 6) {
                    return "كلمة المرور قصيرة جداً";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              InputField(
                labelText: 'تأكيد كلمة المرور',
                hintText: '••••••••',
                controller: rePassController,
                isSecure: true,
                isNumberOnly: false,
                icon: Icon(Icons.lock, color: Color(0xFF0F67FF), size: 23),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إعادة إدخال كلمة المرور";
                  }
                  if (rePassController != passController) {
                    return "كلمة المرور غير متطابقة";
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0F67FF),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("LOGIN SUCCESS as $selectedType");
                    }
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontFamily: "almarai",
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '  لديك حساب؟ ',
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
                     Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginView(),
                ),
              );
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

class InputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isSecure;
  final Icon icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isNumberOnly;

  const InputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.isSecure,
    required this.icon,
    required this.controller,
    this.validator,
    required this.isNumberOnly,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField>
    with SingleTickerProviderStateMixin {
  bool showPassword = false;

  late AnimationController _shakeController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _offsetAnimation = Tween<double>(
      begin: 0,
      end: 24,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void togglePassword() {
    setState(() => showPassword = !showPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, right: 15),
      child: AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_offsetAnimation.value - 10, 0),
            child: child,
          );
        },
        child: TextFormField(
          controller: widget.controller,

          obscureText: widget.isSecure ? !showPassword : false,

          validator: (value) {
            final error = widget.validator?.call(value);

            if (error != null) {
              _shakeController.forward().then((_) => _shakeController.reset());
            }

            return error;
          },

          inputFormatters: [
            if (widget.isNumberOnly) FilteringTextInputFormatter.digitsOnly,
          ],

          style: TextStyle(
            fontFamily: 'almarai',
            fontSize: 18,
            color: Colors.black,
          ),

          decoration: InputDecoration(
            hintStyle: TextStyle(fontFamily: "almarai"),
            labelStyle: TextStyle(fontFamily: "almarai"),

            errorStyle: TextStyle(
              fontFamily: "almarai",
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.red,
            ),

            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.icon,
            filled: true,
            fillColor: Colors.blueAccent.withOpacity(0.05),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0F67FF), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),

            suffixIcon: widget.isSecure
                ? IconButton(
                    onPressed: togglePassword,
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
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
